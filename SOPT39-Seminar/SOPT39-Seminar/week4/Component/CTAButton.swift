//
//  CTAButton.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct CTAButton: View {
    let title: String
    var isEnabled: Bool = true
    var isSecondary: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.SemiBold(14))
                .tracking(-0.14)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .background(backgroundColor)
        .clipShape(Capsule())
    }

    private var textColor: Color {
        if !isEnabled { return Color(.gray3) }
        if isSecondary { return Color(.gray5) }
        return Color(.gray1)
    }

    private var backgroundColor: Color {
        if !isEnabled || isSecondary { return Color(.gray1) }
        return Color(.black)
    }
}
