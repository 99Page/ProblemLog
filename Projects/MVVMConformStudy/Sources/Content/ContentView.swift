//
//  ContentView.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        ComponentView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
