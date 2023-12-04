//
//  ColorView.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct ColorView: View {
    
    @State private var colorList: [Color] = [.red ,.blue, .green]
    
    let colorDomain: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .brown, .cyan]
    
    var body: some View {
        RefreshableScrollView {
            VStack {
                ForEach(colorList) {
                    Rectangle()
                        .frame(width: 150, height: 150)
                        .foregroundStyle($0)
                }
            }
        } onRefresh: {
            refresh()
        }
        
    }
    
    private func refresh() {
        colorList = [colorDomain.randomElement()!,
                     colorDomain.randomElement()!,
                     colorDomain.randomElement()!]
    }
}

#Preview {
    ColorView()
}
