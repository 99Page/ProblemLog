//
//  View + addNameSpace.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

/**
 마지막 modifier에 위치해야합니다. 
 */
extension View {
    func addNamespace(name: any Hashable) -> some View {
        VStack(spacing: 0) {
            self
        }
        .coordinateSpace(.named(name))
    }
}
