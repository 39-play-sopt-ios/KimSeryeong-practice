//
//  ChatRoom.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//


import Foundation

struct ChatRoomModel: Identifiable {
    let id = UUID()
    let username: String
    let profileImageName: String
    let lastMessage: String
    let timeText: String
}
