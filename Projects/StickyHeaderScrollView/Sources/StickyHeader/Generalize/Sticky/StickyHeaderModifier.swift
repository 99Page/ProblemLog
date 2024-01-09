//
//  StickyHeaderModifier.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI
import PagePackage

struct StickyHeaderModifier<Header: View>: ViewModifier  {
    
    @State private var containerOriginOffset: CGFloat = .zero
    @Binding var contentOffset: CGFloat
    
    let nameSpace: CoordinateSpace
    
    let header: () -> Header
    
    var stickyHeaderOffset: CGFloat {
        min(0, max(contentOffset, -containerOriginOffset))
    }
    
    var scrollOffset: CGFloat {
        stickyHeaderOffset < 0 ? stickyHeaderOffset : 0
    }
    
    var scrollBottomPadding: CGFloat {
        scrollOffset
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            header()
                .offset(y: stickyHeaderOffset)
                .originOffset(nameSpace: nameSpace) {
                    debugPrint("container origin offset: \($0)")
                    containerOriginOffset = $0
                }
            
            content
                .offset(y: scrollOffset)
                .padding(.bottom, scrollBottomPadding)
        }
    }
}
