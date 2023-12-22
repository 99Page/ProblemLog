//
//  PartialLoadingViewModel.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class LocalLoadingViewModel: ObservableObject {
    @Published var model: LocalLoadingModel
    
    init(localLoadingModel: LocalLoadingModel) {
        self.model = localLoadingModel
        
    }
    
    func load() async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard self.model.shouldNavigateAfterLoading else { return }
            Navigator.shared.navigate(
                to: .partiallyLoading(
                    .init(shouldNavigateAfterLoading: false)
                )
            )
        }
    }
    
    func add() {
        Task {
            model.count += 1 
        }
    }
    
    func addInMainActor() {
        Task {
            await MainActor.run {
                model.count += 1 
            }
        }
    }
}
