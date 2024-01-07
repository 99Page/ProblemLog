//
//  DetectScrollOffsetTestView.swift
//  PagePackage
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct DetectScrollOffsetTestView: View {
    
    @State private var offset: CGFloat = .zero
    var body: some View {
        ScrollView {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.2))
                .frame(width: 180, height: 60)
                .controllScrollOffset(nameSpace: .named("scroll")) {
                    offset = $0
                }
            
            Text("\(offset)")
        }
        .coordinateSpace(name: "scroll")
    }
}

#Preview {
    DetectScrollOffsetTestView()
}
