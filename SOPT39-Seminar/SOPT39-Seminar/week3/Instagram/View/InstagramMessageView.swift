//
//  InstagramMessageView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//
// 제출용 실습

import SwiftUI

struct InstagramMessageView: View {
    @State private var viewModel = ChatViewModel()

    var body: some View {
        List(viewModel.chatrooms) { message in
            MessageRowView(item: message)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                )
                .listRowBackground(Color.white)
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 72)
        .scrollContentBackground(.hidden)
        .background(.white)
    }
}

#Preview {
    InstagramMessageView()
}
