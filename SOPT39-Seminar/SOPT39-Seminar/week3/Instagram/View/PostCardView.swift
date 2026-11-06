//
//  PostCardView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//


//
//  PostCardView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/10/26.
//

import SwiftUI

struct PostCardView: View {
    let isLiked: Bool
    let onLikeTapped: () -> Void //추가된 클로저

    let profileImage: Image
    let userName: String
    let location: String
    let postImage: Image
    let likeText: String
    let caption: String
    let timeText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PostProfileHeaderView(
                profileImage: profileImage,
                userName: userName,
                location: location
            )

            postMainImage
            postIcon
            postMessage
        }
        .background(.white)
        .foregroundStyle(.black)
    }

    private var postMainImage: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                postImage
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
            .overlay(alignment: .topTrailing) {
                Text("1/3")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.black.opacity(0.7), in: Capsule())
                    .padding(16)
            }
    }

    private var postIcon: some View {
        HStack(spacing: 17) {
            Button {
                onLikeTapped() //추가된 부분
            } label: {
                Image(isLiked ? "Like" : "Like_empty")
            }

            Image("Comment")
            Image("Messanger")

            Spacer()

            Image("Save")
        }
        .font(.system(size: 24, weight: .light))
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var postMessage: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 17, height: 17)
                    .clipShape(Circle())

                Text(likeText)
                    .font(.system(size: 14))
            }

            Text("\(Text(userName).fontWeight(.semibold)) \(caption)")                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)

            Text(timeText)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}
