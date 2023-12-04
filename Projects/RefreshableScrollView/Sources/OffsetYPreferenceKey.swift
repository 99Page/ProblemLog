//
//  OffsetYPreferenceKey.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/4/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct OffsetYPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct PaginationTriggerPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
