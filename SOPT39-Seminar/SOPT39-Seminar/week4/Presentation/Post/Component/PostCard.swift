//
//  PostCard.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostCard: View {
    let author: String
    let date: String
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(author)
                Rectangle()
                    .frame(width: 1, height: 12)
                    .accessibilityHidden(true)
                Text(date)
            }
            .font(.Medium(12))
            .tracking(-0.12)
            .foregroundStyle(Color(.gray3))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.Medium(16))
                    .tracking(-0.16)
                Text(content)
                    .font(.Medium(14))
                    .tracking(-0.14)
            }
            .foregroundStyle(Color(.gray5))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.gray1))
        .cornerRadius(20)
    }
}
