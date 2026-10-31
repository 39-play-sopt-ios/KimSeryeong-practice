//
//  ChatViewModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import Observation

@Observable
final class ChatViewModel {
    private(set) var chatrooms: [ChatRoomModel] = [
        ChatRoomModel(
            username: "juju",
            profileImageName: "moayo",
            lastMessage: "안녕하세요 주주예용",
            timeText: "지금"
        ),
        ChatRoomModel(
            username: "huihui",
            profileImageName: "moayo",
            lastMessage: "반가워용 희희예용",
            timeText: "지금"
        ),
        ChatRoomModel(
            username: "yupyup",
            profileImageName: "moayo",
            lastMessage: "3차 세미나 렛쮸고",
            timeText: "15m"
        ),
        ChatRoomModel(
            username: "tacos",
            profileImageName: "taco",
            lastMessage: "아~~ 재밌다 😂😂😂",
            timeText: "20m"
        ),
        ChatRoomModel(
            username: "kk_kk",
            profileImageName: "moayo",
            lastMessage: "나의 노래를 들어보실분 나는 케케",
            timeText: "1m"
        ),
        ChatRoomModel(
            username: "hello_moa",
            profileImageName: "moayo",
            lastMessage: "모아요에 오신 걸 환영",
            timeText: "2h"
        ),
        ChatRoomModel(
            username: "goTosleep",
            profileImageName: "moayo",
            lastMessage: "쿨쿨...",
            timeText: "4h"
        ),
        ChatRoomModel(
            username: "hungryMan",
            profileImageName: "moayo",
            lastMessage: "저랑 떵개하실래요?",
            timeText: "5h"
        ),
        ChatRoomModel(
            username: "moamoayo",
            profileImageName: "moayo",
            lastMessage: "모아요에서 사과 한 입! 앙~",
            timeText: "10h"
        )
    ]
}

