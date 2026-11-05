//
//  BottomSheet.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color(.gray3))
                .frame(width: 36, height: 4)
                .padding(.top, 12)
                .padding(.bottom, 20)
                .accessibilityHidden(true)

            content()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.white))
        .presentationDragIndicator(.hidden)
        .presentationCornerRadius(24)
        .presentationBackground(Color(.white))
    }
}
