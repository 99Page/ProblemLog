//
//  ContentView.swift
//  Viewmodel-Delegate-Study
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    CountParentView()
                } label: {
                    Text("ViewModel case")
                }
                
                NavigationLink {
                    ColorCircleView()
                } label: {
                    Text("Delegate case")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
