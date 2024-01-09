//
//  CollpasedHeaderScrollView.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/9/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

/**
 general하게 사용하려면 알아야 할 값은?
 
 1. Expanded header와 Collapsed header가 교체되기 위한 값
 2. Sticky header가 움직이기 위한 값
 
 -> 재사용 하는 상위 뷰에서 계산해서 넘겨줘야한다!
 
 예제처럼 순차적으로 타이틀이 있는 경우는 해결할 수 있지만,
 계속 추가적으로 sticky하게 하고 싶은 경우는, 결국 상위뷰에서 오프셋을 알고 있어야한다.
 애초에 재사용하기 어렵다.
 
 상위 뷰에서 움직이기 위한 제한을 알고, 제어해주는게 최선이다. 
 */
struct CollpasedHeaderScrollView: View {
    
    //  MARK: not important property
    @State private var selectedColor: Color = .red
    @State private var expandedTitleHeight: CGFloat = .zero
    @State private var collpasedTitleMaxY: CGFloat = .zero
    @State private var stickToCollpasedHeaderMinY: CGFloat = .zero
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    //  MARK: For stickt header value
    @State private var contentOffset: CGFloat = .zero
    
    var expandedHeaderOffset: CGFloat {
        contentOffset < 0 ? contentOffset : 0
    }
    
    var expandedHeaderOpacity: CGFloat {
        expandedTitleHeight + contentOffset
    }
    
    var collapsedHeaderOpacity: CGFloat {
        1 - expandedHeaderOpacity
    }
    
    var stickyHeaderOffset: CGFloat {
        min(max(collpasedTitleMaxY - stickToCollpasedHeaderMinY, contentOffset), 0)
    }
    
    var body: some View {
        content()
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            VStack(spacing: 0) {
                Text("Title")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom)
                    .foregroundStyle(Color.white)
                    .opacity(collapsedHeaderOpacity)
                    .zIndex(1)
                    .background {
                        Color.blue
                            .ignoresSafeArea(.container, edges: .top)
                    }
                    .backgroundCGFloat(keyPath: \.maxY, nameSpace: .named("container")) {
                        collpasedTitleMaxY = $0
                    }
                
                Text("Title")
                    .foregroundStyle(.white)
                    .font(.system(size: 30, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                    .background {
                        Color.blue
                    }
                    .backgroundCGFloat(keyPath: \.height, nameSpace: .named("container")) {
                        expandedTitleHeight = $0
                    }
                    .opacity(expandedHeaderOpacity)
                    .offset(y: expandedHeaderOffset)
                    .zIndex(0)
            }
            
            Button {
                    selectedColor = colors.randomElement() ?? .blue
            } label: {
                HStack {
                    Text("Color change, offset: \(collpasedTitleMaxY)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.primary)
                }
            }
            .backgroundCGFloat(keyPath: \.minY, nameSpace: .named("container")) {
                stickToCollpasedHeaderMinY = $0
            }
            .offset(y: stickyHeaderOffset)
            .padding(.bottom, stickyHeaderOffset)
            
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
            .offset(y: stickyHeaderOffset / 2)
            .padding(.bottom, stickyHeaderOffset)

        }
        .coordinateSpace(.named("container"))
        .toolbarBackground(Color.blue, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    CollpasedHeaderScrollView()
}

#Preview("vanlia title") {
    NavigationStack {
        ScrollView {
            
        }
        .navigationTitle("Vanlia title")
    }
}
