//
//  PostTextField.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.SemiBold(16))
                .tracking(-0.16)
                .foregroundStyle(Color(.gray6))
                .padding(.leading, 8)

            TextField(placeholder, text: $text, prompt: prompt)
                .font(.Medium(18))
                .tracking(-0.18)
                .foregroundStyle(Color(.gray5))
                .tint(Color(.gray5))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFocused)
                .accessibilityLabel(title)
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(borderColor, lineWidth: 2)
                }
        }
    }

    private var prompt: Text {
        Text(placeholder).foregroundStyle(Color(.gray2))
    }

    private var borderColor: Color {
        if isFocused { return Color(.gray5) }
        return Color(.gray2)
    }
}
