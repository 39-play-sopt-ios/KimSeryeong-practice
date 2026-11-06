//
//  SectionList.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI

struct SectionList: View {
    struct MoaMoa: Identifiable {
        let id = UUID()
        let name: String
    }
    
    struct MoaGroup: Identifiable {
        let id = UUID()
        let name: String
        let members: [MoaMoa]
    }
    
    private let moaGroups = [
        MoaGroup(
            name: "1조",
            members: [
                MoaMoa(name: "성환"),
                MoaMoa(name: "세령")
            ]
        ),
        MoaGroup(
            name: "2조",
            members: [
                MoaMoa(name: "서영"),
                MoaMoa(name: "주희")
            ]
        ),
        MoaGroup(
            name: "3조",
            members: [
                MoaMoa(name: "보민"),
                MoaMoa(name: "보영")
            ]
        ),
        MoaGroup(
            name: "4조",
            members: [
                MoaMoa(name: "시언"),
                MoaMoa(name: "다연")
            ]
        )
    ]
    
    @State private var singleSection: UUID?
    
    var body: some View {
        NavigationStack {
            List(selection: $singleSection) {
                ForEach(moaGroups) {
                    group in Section(group.name) {
                        ForEach(group.members) {
                            moayo in Text(moayo.name)
                                .tag(moayo.id)
                        }
                    }
                }
            }
        }
        .navigationTitle("모아요 이름 목록")
    }
}
