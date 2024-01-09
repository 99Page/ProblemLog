//
//  TempFile.swift
//  PagePackage
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

public extension View {
    func controllScrollOffset(nameSpace: CoordinateSpace,
                              closure: @escaping (CGFloat) -> ()) -> some View {
        self
            .background {
                GeometryReader { geometry in
                    let float = geometry.frame(in: nameSpace).minY
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self,
                                    value: float)
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
                    closure($0)
                }
            }
    }
}


public extension View {
    func backgroundCGFloat(keyPath: KeyPath<CGRect, CGFloat>,
                           nameSpace: CoordinateSpace,
                           closure: @escaping (CGFloat) -> ()) -> some View {
        self
            .background {
                GeometryReader { geometry in
                    let float = geometry.frame(in: nameSpace)[keyPath: keyPath]
                    Color.clear
                        .onAppear {
                            closure(float)
                        }
                }
            }
    }
}
