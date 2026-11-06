//
//  PostView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostView: View {
    private let author: String
    @State private var viewModel: PostViewModel
    @State private var isDeleteModalPresented = false
    @State private var deletingPost: PostItemModel?
    @State private var editingPost: PostItemModel?
    @State private var title = ""
    @State private var content = ""
    @State private var isSheetPresented = false

    init(posts: [PostItemModel]? = nil, authorizationCode: String = "", author: String) {
        self.author = author
        _viewModel = State(
            initialValue: PostViewModel(posts: posts, authorizationCode: authorizationCode)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            searchField
            postList
        }
        .background(Color(.white))
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.scheduleSearch()
        }
        .onDisappear {
            viewModel.cancelScheduledSearch()
        }
        .task(id: viewModel.searchRevision) {
            await viewModel.loadPosts()
        }
        .overlay(alignment: .bottomTrailing) {
            floatingButton
        }
        .overlay {
            deleteModal
        }
        .sheet(isPresented: $isSheetPresented) {
            postSheet
        }
    }

    private var searchField: some View {
        SearchTextField(text: $viewModel.searchText, onSearch: viewModel.search)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
    }

    private var postList: some View {
        List(viewModel.displayedPosts) { post in
            postRow(post)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .overlay {
            emptySearchMessage
        }
    }

    private var floatingButton: some View {
        FloatingButton(action: presentCreateSheet)
            .padding(.trailing, 16)
            .padding(.bottom, 14)
    }

    @ViewBuilder
    private var deleteModal: some View {
        if isDeleteModalPresented {
            PostModal(isPresented: $isDeleteModalPresented, onDelete: deletePost)
        }
    }

    private var postSheet: some View {
        PostBottomSheet(
            title: $title,
            content: $content,
            initialPost: editingPost,
            onSubmit: submitPost
        )
    }

    @ViewBuilder
    private var emptySearchMessage: some View {
        if viewModel.displayedPosts.isEmpty && !viewModel.submittedSearchText.isEmpty {
            Text("검색 결과가 없습니다.")
                .font(.Medium(14))
                .foregroundStyle(Color(.gray3))
        }
    }

    private func postRow(_ post: PostItemModel) -> some View {
        PostCard(
            author: post.author,
            date: post.date,
            title: post.title,
            content: post.content
        )
        .contentShape(RoundedRectangle(cornerRadius: 20))
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .exclusively(before: TapGesture())
                .onEnded { value in
                    switch value {
                    case .first:
                        presentDeleteModal(for: post)
                    case .second:
                        presentEditSheet(for: post)
                    }
                }
        )
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
        .listRowBackground(Color(.white))
    }

    private func presentCreateSheet() {
        editingPost = nil
        title = ""
        content = ""
        isSheetPresented = true
    }

    private func presentEditSheet(for post: PostItemModel) {
        editingPost = post
        title = post.title
        content = post.content
        isSheetPresented = true
    }

    private func presentDeleteModal(for post: PostItemModel) {
        deletingPost = post
        isDeleteModalPresented = true
    }

    private func deletePost() {
        isDeleteModalPresented = false
        if let deletingPost {
            Task { await viewModel.deletePost(deletingPost) }
        }
    }

    private func submitPost() {
        let submittedTitle = title
        let submittedContent = content
        let postToEdit = editingPost
        isSheetPresented = false
        Task {
            if let postToEdit {
                await viewModel.updatePost(
                    postToEdit,
                    title: submittedTitle,
                    content: submittedContent
                )
            } else {
                await viewModel.createPost(
                    title: submittedTitle,
                    content: submittedContent,
                    author: author
                )
            }
        }
    }
}

#Preview {
    PostView(posts: PostItemModel.posts, author: "솝트")
}

#Preview("빈 목록") {
    PostView(posts: [], author: "솝트")
}
