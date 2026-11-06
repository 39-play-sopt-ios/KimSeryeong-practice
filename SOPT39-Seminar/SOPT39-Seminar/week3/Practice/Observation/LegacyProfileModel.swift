//
//  LegacyProfileModel.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//


import SwiftUI
import Combine

final class LegacyProfileModel: ObservableObject {
    @Published var nickname = "모아요"
    @Published var isPublic = true
}
