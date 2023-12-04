//
//  ContentView.swift
//  PlaceholdingTextEditor
//
//  Created by wooyoung on 2023/10/24.
//

import SwiftUI

struct VanilaRefreshableView: View {
    
    @State private var colorList: [Color] = [.red ,.blue, .green]
    
    let colorDomain: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .brown, .cyan]
    var body: some View {
        ScrollView {
            ForEach(colorList) { color in
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(color)
            }
        }
        .refreshable {
            Task {
                do {
                    try await Task.sleep(for: .seconds(2))
                    colorList = [colorDomain.randomElement()!,
                                 colorDomain.randomElement()!,
                                 colorDomain.randomElement()!]
                    debugPrint("Refresh")
                } catch {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VanilaRefreshableView()
    }
}
