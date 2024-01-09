//
//  SticktHeaderScrollView.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI
import PagePackage

/**
 Scroll view의 내부에는 반복되는 컨텐츠만 사용하는 편이 좋다.
 다른 것들은 옵션들은 외부로 꺼내자.
 */
struct SticktHeaderScrollSampleView: View {
    
    
    //  MARK: not important property
    @State private var selectedColor: Color = .red
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    //  MARK: For stickt header value
    @State private var contentOffset: CGFloat = .zero
    @State private var containerOriginOffset: CGFloat = .zero
    
    var offset: CGFloat {
        contentOffset > 0 ? 0 : -contentOffset
    }
    
    var disappearableHeaderOffset: CGFloat {
        min(0, contentOffset)
    }
    
    var stickyHeaderOffset: CGFloat {
        min(0, max(contentOffset, -containerOriginOffset))
    }
    
    var scrollOffset: CGFloat {
        stickyHeaderOffset < 0 ? stickyHeaderOffset : 0
    }
    
    var scrollBottomPadding: CGFloat {
        scrollOffset
    }
    
    var body: some View {
        content()
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            Text("Title")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .offset(y: disappearableHeaderOffset)
            
            Text("origin offset diff: \(containerOriginOffset)")
                .offset(y: disappearableHeaderOffset)
            
            Button {
                    selectedColor = colors.randomElement() ?? .blue
            } label: {
                HStack {
                    Text("Color change, offset: \(contentOffset)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.primary)
                }
            }
            .offset(y: stickyHeaderOffset)
            .originOffset(nameSpace: .named("container")) {
                containerOriginOffset = $0
            }
            
            ScrollView {
                VStack {
                    ForEach(0..<20, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedColor.opacity(0.2))
                            .frame(width: 210, height: 70)
                    }
                }
                .frame(maxWidth: .infinity)
                .controllScrollOffset(nameSpace: .named("scrollview")) {
                    contentOffset = $0
                }
            }
            .coordinateSpace(.named("scrollview"))
            .offset(y: scrollOffset)
            .padding(.bottom, scrollBottomPadding)
        }
        .padding(.all, 1)
        .coordinateSpace(.named("container"))
    }
}

#Preview {
    SticktHeaderScrollSampleView()
}
