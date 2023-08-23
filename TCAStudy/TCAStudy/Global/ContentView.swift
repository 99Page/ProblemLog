//
//  ContentView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Counter") {
                CounterView(store: Store(initialState: Counter.State(), reducer: {
                    Counter()
                }))
            }
            
            NavigationLink("OptionalState") {
                OptionalBasicsView(store: Store(initialState: OptionalBasics.State(), reducer: {
                    OptionalBasics()
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
