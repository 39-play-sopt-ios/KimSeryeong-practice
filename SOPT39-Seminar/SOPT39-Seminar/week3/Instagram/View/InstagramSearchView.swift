//
//  InstagramSearchView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//
// 제출용 실습

import SwiftUI

struct InstagramSearchView: View {
    
    @State private var searchText = ""
    
    private let columnCount = 3
    private let rowCount = 6
    
    var body: some View {
        VStack(spacing: 23) {
            searchBar
            
            ScrollView {
                Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<6, id: \.self) { row in
                        GridRow {
                            ForEach(0..<3, id: \.self) { column in
                            let index = row * 3 + column
                            
                                Color.clear
                                .aspectRatio(1, contentMode: .fit)
                                .overlay {
                                    Image("Rectangle\(index)")
                                        .resizable()
                                        .scaledToFill()
                                }
                                .clipped()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 13) {
            TextField("검색", text: $searchText)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(Color(.gray100))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray200, lineWidth: 1)
                    }

            Image("Save")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 23)
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    InstagramSearchView()
}
