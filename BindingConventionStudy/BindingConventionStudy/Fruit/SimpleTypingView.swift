//
//  ContentView.swift
//  BindingConventionStudy
//
//  Created by wooyoung on 2023/11/01.
//

import SwiftUI

struct SimpleTypingView: View {
    
    @StateObject private var viewModel = SimpleTypingViewModel()
    var body: some View {
        List {
            TextField("Title", text: $viewModel.model.text)
                .onChange(of: viewModel.model.text) { oldValue, newValue in
                    debugPrint("\(oldValue), \(newValue)")
                }
            TextField("Description", text: viewModel.descriptionBinding)
        }
    }
}

#Preview {
    SimpleTypingView()
}
