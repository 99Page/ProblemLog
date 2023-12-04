//
//  RefreshableScrollView.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

/**
 ScrollView의 이동에 따라서 내부 컨텐츠를 초기화하고 싶을 때 사용합니다.
 
 주의: 반드시 VStack 혹은 HStack 등의 Container를 감싼 View를 선언해야 합니다/ 
 */
struct RefreshableScrollView<Content: View> : View {
    
    @StateObject private var viewModel: RefreshableScrollViewModel
    
    private let view: () -> Content
    private let completion: () -> ()
    
    init(view: @escaping () -> Content,
         onRefresh completion: @escaping () -> Void,
         refreshThreshold: CGFloat = 100) {
        self.completion = completion
        self.view = view
        
        let viewModel = RefreshableScrollViewModel(refreshThreshold: refreshThreshold)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            offsetProviderView()
            view()
                .background {
                    ScrollDetector { _, velocity in
                        viewModel.model.dragVelocity = velocity
                    }
                }
        }
        .onPreferenceChange(OffsetYPreferenceKey.self) {
            viewModel.model.scrollOffset = $0
        }
        .overlay(alignment: .top) {
            Image(systemName: "arrow.clockwise")
                .rotationEffect(.degrees(viewModel.model.rotatingDegree))
                .opacity(viewModel.model.opacity)
        }
        .onChange(of: viewModel.model.dragVelocity) { _, _ in
            guard viewModel.model.isRefreshEnabled else { return }
            completion() 
        }
    }
    
    private func offsetProviderView() -> some View {
        Color.clear
            .frame(height: 1)
            .overlay(alignment: .top) {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    
                    Color.clear.preference(key: OffsetYPreferenceKey.self,
                                           value: minY)
                }
            }
    }
}

#Preview {
    ColorView()
}
