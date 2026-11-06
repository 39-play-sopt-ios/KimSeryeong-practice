//
//  PostUpdateResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/5/26.
//

import Foundation

struct PostUpdateResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: PostResponseDTO?
}
