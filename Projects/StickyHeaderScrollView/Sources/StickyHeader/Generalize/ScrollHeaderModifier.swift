//
//  StickyHeaderModifier.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct ScrollHeaderModifier<Header: View>: ViewModifier  {
    
    @State private var containerOriginOffset: CGFloat = .zero
    @Binding var contentOffset: CGFloat
    
    let header: () -> Header
    
    var offset: CGFloat {
        contentOffset > 0 ? 0 : -contentOffset
    }
    
    var disappearableHeaderOffset: CGFloat {
        min(0, contentOffset)
    }
    
    var stickyHeaderOffset: CGFloat {
        min(0, max(contentOffset, -containerOriginOffset))
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            header()
                .offset(y: disappearableHeaderOffset)
            
            content
        }
    }
}
