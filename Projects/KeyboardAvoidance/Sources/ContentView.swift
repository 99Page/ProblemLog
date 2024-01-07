//
//  ContentView.swift
//  MultiTextEditor
//
//  Created by 노우영 on 12/28/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Scroll view + Text field") {
                    NavigationLink("Single text") {
                        SingleTextCaseView()
                    }
                    
                    NavigationLink("Multiple text") {
                        DoubleTextCaseView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
