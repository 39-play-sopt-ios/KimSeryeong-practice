//
//  Modal.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct Modal<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            Color(.black).opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { }
                .accessibilityHidden(true)

            content()
                .padding(20)
                .frame(width: 288)
                .background(Color(.white))
                .cornerRadius(12)
                .accessibilityAddTraits(.isModal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
