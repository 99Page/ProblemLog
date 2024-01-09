//
//  View + originOffset.swift
//  PagePackage
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

public extension View {
    func originOffset(nameSpace: CoordinateSpace,
                              closure: @escaping (CGFloat) -> ()) -> some View {
        self
            .background {
                GeometryReader { geometry in
                    let float = geometry.frame(in: nameSpace).minY
                    Color.clear
                        .onAppear {
                            closure(float)
                        }
                }
            }
    }
}

