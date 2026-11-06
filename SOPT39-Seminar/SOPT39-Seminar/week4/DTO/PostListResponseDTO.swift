//
//  PostListResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Foundation

struct PostListResponseDTO: Decodable {
    let isSuccess: Bool
    let message: String
    let data: PostListDataDTO?
}

struct PostListDataDTO: Decodable {
    let posts: [PostResponseDTO]
}

struct PostResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let createdAt: String

    func toModel() throws -> PostItemModel {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.isLenient = false
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = String(createdAt.prefix(10))
        guard let date = formatter.date(from: dateString),
            formatter.string(from: date) == dateString
        else {
            throw NetworkError.responseDecodingError
        }
        formatter.dateFormat = "yyyy.MM.dd"
        return PostItemModel(
            id: String(id),
            author: author,
            date: formatter.string(from: date),
            title: title,
            content: content
        )
    }
}
