//
//  CustomPreferenceKey.swift
//  PagePackage
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
    
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = .zero
}
