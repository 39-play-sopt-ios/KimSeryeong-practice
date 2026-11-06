//
//  PostView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostView: View {
    @State private var viewModel: PostViewModel
    @State private var isDeleteModalPresented = false
    @State private var deletingPost: PostItemModel?
    @State private var editingPost: PostItemModel?
    @State private var title = ""
    @State private var content = ""
    @State private var isSheetPresented = false

    init(posts: [PostItemModel]? = nil, authorizationCode: String = "") {
        _viewModel = State(
            initialValue: PostViewModel(posts: posts, authorizationCode: authorizationCode)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $viewModel.searchText, onSearch: viewModel.search)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            postList
        }
        .background(Color(.white))
        .task(id: viewModel.searchRevision) {
            await viewModel.loadPosts()
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton { }
                .padding(.trailing, 16)
                .padding(.bottom, 14)
        }
        .overlay {
            if isDeleteModalPresented {
                PostModal(isPresented: $isDeleteModalPresented) {
                    isDeleteModalPresented = false
                    if let deletingPost {
                        Task { await viewModel.deletePost(deletingPost) }
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            PostBottomSheet(
                title: $title,
                content: $content,
                initialPost: editingPost,
                onSubmit: updatePost
            )
        }
    }

    private var postList: some View {
        List(viewModel.displayedPosts) { post in
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
                            deletingPost = post
                            isDeleteModalPresented = true
                        case .second:
                            editingPost = post
                            title = post.title
                            content = post.content
                            isSheetPresented = true
                        }
                    }
            )
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
            .listRowBackground(Color(.white))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .overlay {
            if viewModel.displayedPosts.isEmpty && !viewModel.submittedSearchText.isEmpty {
                Text("검색 결과가 없습니다.")
                    .font(.Medium(14))
                    .foregroundStyle(Color(.gray3))
            }
        }
    }

    private func updatePost() {
        guard let editingPost else { return }
        let updatedTitle = title
        let updatedContent = content
        isSheetPresented = false
        Task {
            await viewModel.updatePost(editingPost, title: updatedTitle, content: updatedContent)
        }
    }
}

#Preview {
    PostView(posts: PostItemModel.posts)
}

#Preview("빈 목록") {
    PostView(posts: [])
}
