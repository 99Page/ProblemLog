//
//  RefreshablePaginatedScrollView.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct RefreshablePaginatedScrollView<Content: View>: View {
    
    @StateObject private var viewModel: PaginationViewModel
    
    private let view: () -> Content
    private let refresh: () -> ()
    
    init(view: @escaping () -> Content,
         onRefresh refresh: @escaping () -> (),
         onFetch fetch: @escaping () -> (),
         refreshThreshold: CGFloat = 100) {
        self.refresh = refresh
        self.view = view
        let viewModel = PaginationViewModel(fetch: fetch)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RefreshableScrollView {
            VStack {
                view()
                
                if viewModel.model.isProgressViewPresented {
                    ProgressView()
                }
                
                offsetProviderView()
            }
        } onRefresh: {
            refresh()
        }
        .onPreferenceChange(PaginationTriggerPreferenceKey.self) {
            viewModel.model.fetchTriggerOffset = $0
        }
        .onChange(of: viewModel.model.fetchTriggerOffset) {
            viewModel.fetchIfPossible()
        }
    }
    
    private func offsetProviderView() -> some View {
        Color.clear
            .frame(height: 1)
            .overlay(alignment: .top) {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    
                    Color.clear.preference(key: PaginationTriggerPreferenceKey.self,
                                           value: minY)
                }
            }
    }
}

#Preview {
    RefreshablePaginatedScrollView {
        Text("RefreshablePaginatedScrollView")
    } onRefresh: {
        debugPrint("refresh")
    } onFetch: {
        debugPrint("fetch")
    }


}
