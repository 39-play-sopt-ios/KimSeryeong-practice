//
//  PostBottomSheet.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 11/4/26.
//

import SwiftUI

struct PostBottomSheet: View {
    @Binding var title: String
    @Binding var content: String
    var initialPost: PostItemModel? = nil
    let onSubmit: () -> Void

    var body: some View {
        BottomSheet {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        PostTextField(
                            title: "제목",
                            placeholder: "제목을 입력하세요.",
                            text: $title
                        )

                        PostTextField(
                            title: "본문",
                            placeholder: "본문을 입력하세요.",
                            text: $content
                        )
                    }

                    CTAButton(title: "완료", isEnabled: isEnabled, action: onSubmit)
                }
            }
            .scrollIndicators(.hidden)
        }
        .presentationDetents([.height(275)])
        .onChange(of: title, initial: true) { _, newValue in
            if newValue.count > 20 { title = String(newValue.prefix(20)) }
        }
        .onChange(of: content, initial: true) { _, newValue in
            if newValue.count > 1000 { content = String(newValue.prefix(1000)) }
        }
    }

    private var isEnabled: Bool {
        title.count <= 20
            && content.count <= 1000
            && (initialPost == nil || title != initialPost?.title
                || content != initialPost?.content)
    }
}
