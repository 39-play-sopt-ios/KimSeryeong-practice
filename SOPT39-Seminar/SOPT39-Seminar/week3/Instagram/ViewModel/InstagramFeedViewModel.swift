//
//  InstagramFeedViewModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import Foundation
import Observation

@Observable
final class InstagramFeedViewModel {
    private(set) var examplePosts: [PostModel] = [
        PostModel(
            username: "이상엽",
            location: "서울 대한민국",
            postImageName: "postImage1",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "벌써 2차 세미나라니 정말 즐거워요!",
            timeText: "1시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage3",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        ),
        PostModel(
            username: "모아요",
            location: "아요의 숲",
            postImageName: "postImage2",
            likesText: "모아요님 외 7,777명이 좋아합니다",
            caption: "같은 카드에 다른 데이터를 전달해보기~",
            timeText: "2시간 전"
        )
        
    ]

    func toggleLike(id: PostModel.ID) {
        guard let index = examplePosts.firstIndex(where: { $0.id == id }) else {
            return
        }

        examplePosts[index].isLiked.toggle()
    }
}
