//
//  PartialLoadingView.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct LocalLoadingView: View {
    @StateObject private var viewModel: LocalLoadingViewModel
    
    init(_ localLoadingModel: LocalLoadingModel) {
        let viewModel = LocalLoadingViewModel(localLoadingModel: localLoadingModel)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(content: {
            if viewModel.model.isLoading {
                ProgressView()
            } else {
                Rectangle()
                    .foregroundStyle(.red)
            }
        })
        .onAppear {
            Task { await viewModel.load() }
        }
    }
}

#Preview {
    LocalLoadingView(.init(shouldNavigateAfterLoading: false))
}
