//
//  PostProfileHeaderView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//


//
//  PostProfileHeaderView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/10/26.
//

import SwiftUI

struct PostProfileHeaderView : View {
    let profileImage: Image
    let userName: String
    let location: String
    
    var body: some View {
        HStack(spacing: 10) {
            profileImage
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(userName)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(location)
                    .font(.system(size: 12))
            }
            Spacer()
            
            Image("More Icon")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
    }
}
