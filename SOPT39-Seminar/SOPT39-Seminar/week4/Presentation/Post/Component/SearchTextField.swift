//
//  SearchTextField.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    let onSearch: () -> Void
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 10) {
            TextField("검색어를 입력하세요", text: $text, prompt: prompt)
                .font(.Medium(18))
                .tracking(-0.18)
                .foregroundStyle(Color(.gray5))
                .tint(Color(.gray5))
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.search)
                .onSubmit(search)

            Button(action: search) {
                Image(.search)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(height: 56)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("검색")
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(borderColor, lineWidth: 2)
        }
    }

    private var prompt: Text {
        Text("검색어를 입력하세요").foregroundStyle(Color(.gray2))
    }

    private var borderColor: Color {
        Color(isFocused ? .gray5 : .gray2)
    }

    private func search() {
        isFocused = false
        onSearch()
    }
}
