//
//  GrowingColorView.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct GrowingColorView: View {
    
    @State private var colorList: [Color] = [.red ,.blue, .green]
    let colorDomain: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .brown, .cyan]
    
    var body: some View {
        RefreshablePaginatedScrollView {
            VStack {
                ForEach(colorList) {
                    Rectangle()
                        .frame(width: 150, height: 150)
                        .foregroundStyle($0)
                }
            }
        } onRefresh: {
            refresh()
        } onFetch: {
            fetch()
        }

    }
    
    private func fetch() {
        colorList.append(contentsOf: [
            colorDomain.randomElement()!,
            colorDomain.randomElement()!,
            colorDomain.randomElement()!
        ])
    }
    
    private func refresh() {
        colorList = [colorDomain.randomElement()!,
                     colorDomain.randomElement()!,
                     colorDomain.randomElement()!]
    }
}

#Preview {
    GrowingColorView()
}
