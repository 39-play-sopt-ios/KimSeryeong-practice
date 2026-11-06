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
        var request = try makeRequest()
        if !keyword.isEmpty {
            guard let requestURL = request.url,
                var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
            else {
                throw NetworkError.urlError
            }
            components.queryItems = [URLQueryItem(name: "keyword", value: keyword)]
            guard let url = components.url else { throw NetworkError.urlError }
            request.url = url
        }
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
        let code = authorizationCode
        guard !code.isEmpty else { throw NetworkError.unauthorized }
        var request = try makeRequest()
        request.url = request.url?.appending(path: String(id))
        request.httpMethod = "DELETE"
        request.setValue(code, forHTTPHeaderField: "Authorization")

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
        let code = authorizationCode
        guard !code.isEmpty else { throw NetworkError.unauthorized }
        var request = try makeRequest()
        request.url = request.url?.appending(path: String(id))
        request.httpMethod = "PUT"
        request.setValue(code, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(
                PostUpdateRequestDTO(title: title, content: content)
            )
        } catch {
            throw NetworkError.requestEncodingError
        }
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

    private func makeRequest() throws -> URLRequest {
        let configuredURL = (Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String)
            .flatMap { URL(string: $0) }
        guard let url = baseURL ?? configuredURL,
            url.host != nil
        else {
            throw NetworkError.urlError
        }
        var request = URLRequest(url: url.appending(path: "api/v1/posts"))
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
