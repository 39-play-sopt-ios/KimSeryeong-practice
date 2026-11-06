//
//  MessageRowView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI

struct MessageRowView: View {
    let item: ChatRoomModel

    var body: some View {
        HStack(spacing: 12) {
            Image(item.profileImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 1) {
                Text(item.username)

                HStack(spacing: 8) {
                    Text(item.lastMessage)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(item.timeText)
                        .fixedSize()
                }
            }
            .font(.system(size: 13))
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "camera")
                .font(.system(size: 22, weight: .light))
                .frame(width: 24, height: 24)
                .padding(.leading, 16)
        }
        .frame(height: 72)
    }
}

#Preview {
    MessageRowView(
        item: ChatRoomModel(
            username: "juju",
            profileImageName: "moayo",
            lastMessage: "안녕하세요 주주예용",
            timeText: "지금"
        )
    )
    .padding(.horizontal, 16)
}
