//
//  LikeObservationPracticeView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI
import Observation

@Observable
final class Post {
    var author = "모아요"
    var isLiked = false
}

struct LikeObservationPracticeView: View {
    @State private var post = Post()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(post.author)
                .font(.headline)
            
            Button {
                post.isLiked.toggle()
                print("현재 좋아요 상태:", post.isLiked)
            } label: {
                Label(
                    post.isLiked ? "좋아요 취소" : "좋아요",
                    systemImage: post.isLiked ? "heart.fill" : "heart"
                )
                .foregroundStyle(
                    post.isLiked ? Color.red : Color.gray
                )
            }
            
            Text(
                post.isLiked
                ? "좋아요를 눌렀어요!"
                : "아직 좋아요를 누르지 않았어요."
            )
        }
        .padding()
    }
}

#Preview {
    LikeObservationPracticeView()
}
