//
//  PostCreateRequestDTO.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Foundation

struct PostCreateRequestDTO: Encodable {
    let title: String
    let content: String
    let author: String
}
