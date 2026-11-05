//
//  FloatingButton.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(.plus)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .frame(width: 60, height: 60)
                .background(Color(.red))
                .clipShape(Circle())
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
        .accessibilityLabel("게시글 추가")
    }
}
