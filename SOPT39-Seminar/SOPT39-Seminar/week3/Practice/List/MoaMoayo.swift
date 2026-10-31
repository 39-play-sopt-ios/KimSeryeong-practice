//
//  MoaMoa.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI

struct MoaMoa: Identifiable {
    let id = UUID()
    let name: String
}

private var moas = [
    MoaMoa(name: "성환"),
    MoaMoa(name: "세령"),
    MoaMoa(name: "서영"),
    MoaMoa(name: "주희"),
]

struct MoaMoayo : View {
    @State private var multiSelection = Set<UUID>()

    var body: some View {
        NavigationStack {
            List(moas, selection: $multiSelection) {
                moayo in Text(moayo.name)
            }
            .navigationTitle("Moas")
            .toolbar { EditButton() }
        }
        
        Text("\(multiSelection.count) selections")
    }
}



#Preview {
    MoaMoayo()
}
