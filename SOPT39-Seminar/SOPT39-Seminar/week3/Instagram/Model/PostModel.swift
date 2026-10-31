
//
//  PostModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/10/26.
//

// 게시글 데이터

import Foundation

struct PostModel: Identifiable {
    let id = UUID()
    let username: String
    let location: String
    let postImageName: String
    let likesText: String
    let caption: String
    let timeText: String
    var isLiked = false
}

let examplePosts: [PostModel] = [
    PostModel(
        username: "김세령",
        location: "마루 360",
        postImageName: "mainImage2",
        likesText: "세령님 외 1,123명이 좋아합니다.",
        caption: "사과 먹을래?",
        timeText: "1시간 전"
    ),
    
    PostModel(
        username: "모아요",
        location: "아요의 숲",
        postImageName: "mainImage",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "같은 카드에 다른 데이터를 전달해보기~",
        timeText: "2시간 전"
    ),
    
    PostModel(
        username: "배고파",
        location: "공덕역",
        postImageName: "mainImage3",
        likesText: "세령님 외 123명이 좋아합니다.",
        caption: "하나둘셋하면 하이디라오로 소환됩니다.",
        timeText: "4시간 전"
    )
]
