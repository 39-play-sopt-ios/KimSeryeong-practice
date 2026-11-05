//
//  PostModal.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostModal: View {
    @Binding var isPresented: Bool
    let onDelete: () -> Void

    var body: some View {
        Modal {
            VStack(spacing: 20) {
                Text("게시글을 삭제할까요?")
                    .font(.Medium(18))
                    .tracking(-0.18)
                    .foregroundStyle(.gray6)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    CTAButton(title: "취소", isSecondary: true) {
                        isPresented = false
                    }

                    CTAButton(title: "삭제", action: onDelete)
                }
            }
        }
    }
}
