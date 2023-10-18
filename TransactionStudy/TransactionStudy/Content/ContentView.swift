//
//  ContentView.swift
//  TransactionStudy
//
//  Created by wooyoung on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @StateObject private var path = NavigateStack()
    
    var body: some View {
        NavigationStack(path: $path.paths) {
            List {
                Button(action: {
                    path.paths.append(10)
                }, label: {
                    Text("Next view")
                })
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        IssuedFullScreenButtonView(viewModel: viewModel)
                        UnissuedFullScreenButtonView(viewModel: viewModel)
                    }
                    .transaction {
                        $0.disablesAnimations = true
                    }
                }
            })
            .navigationDestination(for: Int.self) { value in
                Text("\(value) view")
            }
        }
    }
}
//
//#Preview {
//    ContentView()
//}
