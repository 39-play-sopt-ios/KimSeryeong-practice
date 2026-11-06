//
//  PostItemModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Foundation

struct PostItemModel: Identifiable {
    let id: String
    let author: String
    let date: String
    let title: String
    let content: String

    init(
        id: String = UUID().uuidString,
        author: String,
        date: String,
        title: String,
        content: String
    ) {
        self.id = id
        self.author = author
        self.date = date
        self.title = title
        self.content = content
    }
}

extension PostItemModel {
    static let posts: [PostItemModel] = (0..<2).flatMap { _ in
        [
            PostItemModel(
                author: "아모하는데",
                date: "2026.11.04",
                title: "글쓰기 테스트입니다 우냐야하뿌릿",
                content: String(repeating: "본문입니다. ", count: 1).trimmingCharacters(
                    in: .whitespaces
                )
            ),

            PostItemModel(
                author: "세령",
                date: "2026.11.05",
                title: "모아요들아",
                content: "밥 잘 먹고 잘 자고 다니자 제발"
            ),
        ]
    }
}
