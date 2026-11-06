//
//  TreeList.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI

struct TreeList: View {
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self {self}
        var name: String
        var children: [FileItem]? = nil
        
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
    
    let fileHierarchyData: [FileItem] = [
        FileItem(name: "모아요", children: [
            FileItem(name: "1조", children: [
                FileItem(name: "성환"),
                FileItem(name: "세령")
            ]),
            FileItem(name: "2조", children: [
                FileItem(name: "서영"),
                FileItem(name: "주희")
            ]),
            FileItem(name: "3조", children: [
                FileItem(name: "보민"),
                FileItem(name: "보영")
            ]),
            FileItem(name: "4조", children: [
                FileItem(name: "시언"),
                FileItem(name: "다연")
            ])
        ])
    ]
    
    var body: some View {
        List(fileHierarchyData, children: \.children) { item in
            Text(item.description)
        }
    }
}

#Preview {
    TreeList()
}
