//
//  PostViewModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class PostViewModel {
    private(set) var posts: [PostItemModel]
    private(set) var searchRevision = 0
    private(set) var error: Error?
    private let shouldLoadPosts: Bool
    private let authorizationCode: String
    private let service: PostService
    private var loadID = UUID()
    private var searchTask: Task<Void, Never>?
    private var isCreating = false
    private var isUpdating = false
    private var isDeleting = false

    var searchText = ""
    private(set) var submittedSearchText = ""

    init(
        posts: [PostItemModel]? = nil,
        authorizationCode: String = "",
        service: PostService = .shared
    ) {
        self.posts = posts ?? []
        self.shouldLoadPosts = posts == nil
        self.authorizationCode = authorizationCode
        self.service = service
    }

    func scheduleSearch() {
        cancelScheduledSearch()
        searchTask = Task { [weak self] in
            do {
                try await Task.sleep(for: .milliseconds(300))
                try Task.checkCancellation()
            } catch {
                return
            }
            self?.search()
        }
    }

    func cancelScheduledSearch() {
        searchTask?.cancel()
        searchTask = nil
    }

    func search() {
        cancelScheduledSearch()
        submittedSearchText = searchText
        searchRevision += 1
    }

    func loadPosts() async {
        guard shouldLoadPosts else { return }
        let currentID = UUID()
        loadID = currentID
        error = nil
        do {
            let loadedPosts = try await service.getPosts(keyword: submittedSearchText)
            try Task.checkCancellation()
            guard loadID == currentID else { return }
            posts = loadedPosts
        } catch is CancellationError {
        } catch let error as URLError where error.code == .cancelled {
        } catch {
            if loadID == currentID { self.error = error }
        }
    }

    func createPost(title: String, content: String, author: String) async {
        guard !isCreating, shouldLoadPosts,
            !title.isEmpty, title.count <= 20,
            !content.isEmpty, content.count <= 1000,
            !author.isEmpty, author.count <= 20
        else { return }
        isCreating = true
        defer { isCreating = false }
        error = nil
        do {
            try await service.createPost(
                title: title,
                content: content,
                author: author,
                authorizationCode: authorizationCode
            )
            await loadPosts()
        } catch {
            self.error = error
        }
    }

    func deletePost(_ post: PostItemModel) async {
        guard !isDeleting else { return }
        isDeleting = true
        defer { isDeleting = false }
        error = nil
        do {
            if shouldLoadPosts {
                guard let serverID = Int(post.id) else { throw NetworkError.badRequest }
                try await service.deletePost(id: serverID, authorizationCode: authorizationCode)
                await loadPosts()
            } else {
                posts.removeAll { $0.id == post.id }
            }
        } catch {
            self.error = error
        }
    }

    func updatePost(_ post: PostItemModel, title: String, content: String) async {
        guard !isUpdating, title.count <= 20, content.count <= 1000,
            title != post.title || content != post.content
        else { return }
        isUpdating = true
        defer { isUpdating = false }
        error = nil
        do {
            if shouldLoadPosts {
                guard let serverID = Int(post.id) else { throw NetworkError.badRequest }
                try await service.updatePost(
                    id: serverID,
                    title: title,
                    content: content,
                    authorizationCode: authorizationCode
                )
                await loadPosts()
            } else if let index = posts.firstIndex(where: { $0.id == post.id }) {
                posts[index] = PostItemModel(
                    id: post.id,
                    author: post.author,
                    date: post.date,
                    title: title,
                    content: content
                )
            }
        } catch {
            self.error = error
        }
    }

    var displayedPosts: [PostItemModel] {
        if shouldLoadPosts || submittedSearchText.isEmpty { return posts }
        return posts.filter { $0.title.localizedCaseInsensitiveContains(submittedSearchText) }
    }
}
