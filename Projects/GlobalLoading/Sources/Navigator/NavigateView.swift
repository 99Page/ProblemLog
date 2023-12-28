//
//  NavigateView.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct NavigateView: View {
    
    @EnvironmentObject var navigator: Navigator
    @EnvironmentObject var globalLoader: GlobalLoader
    
    var body: some View {
        NavigationStack(path: $navigator.navigatinoPath) {
            List {
                Button("Local loading") {
                    navigator.navigate(to: .partiallyLoading(.init(shouldNavigateAfterLoading: true)))
                }
                
                Button("Global loading caller") {
                    navigator.navigate(to: .loadingCaller(.init(text: "First view", shouldNavigateAfterLoading: true)))
                }
                
                Button("Semaphore") {
                    navigator.navigate(to: .semaphore)
                }
            }
            .navigationDestination(for: CustomPath.self) {
                $0.destination
            }
        }
        .overlay {
            if globalLoader.model.isLoadingViewRequired {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
    }
}

#Preview {
    NavigateView()
        .environmentObject(Navigator.shared)
}
