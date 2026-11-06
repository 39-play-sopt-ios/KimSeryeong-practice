//
//  PostService.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Foundation

final class PostService {
    static let shared = PostService()

    private let session: URLSession
    private let baseURL: URL?

    init(session: URLSession = .shared, baseURL: URL? = nil) {
        self.session = session
        self.baseURL = baseURL
    }

    func getPosts(keyword: String = "") async throws -> [PostItemModel] {
        let queryItems = keyword.isEmpty ? [] : [URLQueryItem(name: "keyword", value: keyword)]
        let request = try makeRequest(method: "GET", queryItems: queryItems)
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        guard (200..<300).contains(response.statusCode) else {
            throw NetworkError(statusCode: response.statusCode)
        }

        let result: PostListResponseDTO
        do {
            result = try JSONDecoder().decode(PostListResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
        guard result.isSuccess else {
            throw NetworkError.serverError(message: result.message)
        }
        guard let postData = result.data else {
            throw NetworkError.responseError
        }
        return try postData.posts.map { try $0.toModel() }
    }

    func deletePost(id: Int, authorizationCode: String) async throws {
        guard id > 0 else { throw NetworkError.badRequest }
        let request = try makeRequest(
            method: "DELETE",
            postID: id,
            authorizationCode: authorizationCode
        )

        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        guard (200..<300).contains(response.statusCode) else {
            if let result = try? JSONDecoder().decode(PostDeleteResponseDTO.self, from: data) {
                throw NetworkError.serverError(message: result.message)
            }
            throw NetworkError(statusCode: response.statusCode)
        }
        let result: PostDeleteResponseDTO
        do {
            result = try JSONDecoder().decode(PostDeleteResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
        guard result.isSuccess else {
            throw NetworkError.serverError(message: result.message)
        }
    }

    func updatePost(id: Int, title: String, content: String, authorizationCode: String)
        async throws
    {
        guard id > 0 else { throw NetworkError.badRequest }
        let body: Data
        do {
            body = try JSONEncoder().encode(PostUpdateRequestDTO(title: title, content: content))
        } catch {
            throw NetworkError.requestEncodingError
        }
        let request = try makeRequest(
            body: body,
            method: "PUT",
            postID: id,
            authorizationCode: authorizationCode
        )
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        guard (200..<300).contains(response.statusCode) else {
            if let result = try? JSONDecoder().decode(PostUpdateResponseDTO.self, from: data) {
                throw NetworkError.serverError(message: result.message)
            }
            throw NetworkError(statusCode: response.statusCode)
        }
        let result: PostUpdateResponseDTO
        do {
            result = try JSONDecoder().decode(PostUpdateResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
        guard result.isSuccess else {
            throw NetworkError.serverError(message: result.message)
        }
    }

    private func makeRequest(
        body: Data? = nil,
        method: String,
        postID: Int? = nil,
        queryItems: [URLQueryItem] = [],
        authorizationCode: String? = nil
    ) throws -> URLRequest {
        let configuredURL = (Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String)
            .flatMap { URL(string: $0) }
        guard let url = baseURL ?? configuredURL,
            url.host != nil
        else {
            throw NetworkError.urlError
        }

        let path = postID.map { "api/v1/posts/\($0)" } ?? "api/v1/posts"
        let endpointURL = url.appending(path: path)
        guard var components = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false)
        else {
            throw NetworkError.urlError
        }
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let requestURL = components.url else { throw NetworkError.urlError }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let authorizationCode {
            guard !authorizationCode.isEmpty else { throw NetworkError.unauthorized }
            request.setValue(authorizationCode, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
