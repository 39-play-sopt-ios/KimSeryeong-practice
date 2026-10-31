//
//  LegacyEnvironmentRootView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/17/26.
//

import SwiftUI

struct LegacyEnvironmentRootView: View {
    @StateObject private var profile = LegacyProfileModel()
    
    var body: some View {
        LegacyMiddleView()
            .environmentObject(profile)
    }
}

struct LegacyMiddleView: View {
    var body: some View {
        LegacyDeepProfileView()
    }
}

struct LegacyDeepProfileView: View {
    @EnvironmentObject private var profile: LegacyProfileModel

    var body: some View {
        Text("깊은 곳에서도: \(profile.nickname)")
    }
}
