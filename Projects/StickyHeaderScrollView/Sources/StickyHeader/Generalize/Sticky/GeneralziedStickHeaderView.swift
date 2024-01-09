//
//  GeneralziedStickHeaderView.swift
//  StickyHeaderScrollView
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct GeneralziedStickHeaderView: View {
    
    @State private var contentOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue.opacity(0.1))
                        .frame(width: 210, height: 70)
                }
            }
            .frame(maxWidth: .infinity)
            .controllScrollOffset(nameSpace: .named("scrollview")) {
                contentOffset = $0
            }
        }
        .coordinateSpace(.named("scrollview"))
        .modifier(StickyHeaderModifier(contentOffset: $contentOffset, nameSpace: .named("container"), header: {
            Text("Sticky header!")
        }))
        .modifier(ScrollHeaderModifier(contentOffset: $contentOffset, header: {
            scrollHeader()
        }))
        .addNamespace(name: "container")
    }
    
    @ViewBuilder
    private func scrollHeader() -> some View {
        VStack {
            Text("Title")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            Text("origin offset")
            
            Button {
                
            } label: {
                HStack {
                    Text("Color change, offset: \(contentOffset)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    GeneralziedStickHeaderView()
}
