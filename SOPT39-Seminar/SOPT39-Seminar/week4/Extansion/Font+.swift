//
//  Font+.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/12/26.
//

import SwiftUI

extension Font {
    static func Regular(_ size: CGFloat) -> Font {
        .custom("Pretendard-Regular", size: size)
    }

    static func Medium(_ size: CGFloat) -> Font {
        .custom("Pretendard-Medium", size: size)
    }

    static func SemiBold(_ size: CGFloat) -> Font {
        .custom("Pretendard-SemiBold", size: size)
    }

    static func Bold(_ size: CGFloat) -> Font {
        .custom("Pretendard-Bold", size: size)
    }

    static func ExtraBold(_ size: CGFloat) -> Font {
        .custom("Pretendard-ExtraBold", size: size)
    }
}

// MARK: - Week4 Style Guide

extension Font {
    static let b28: Font = .Bold(28)
    static let m18: Font = .Medium(18)
    static let sb16: Font = .SemiBold(16)
    static let m14: Font = .Medium(14)
    static let sb14: Font = .SemiBold(14)
}
