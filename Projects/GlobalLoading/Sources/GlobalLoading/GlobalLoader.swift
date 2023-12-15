//
//  SimpleViewModel.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

/**
 ObservableObject에 MainActor 매크로를 붙여주면
 Data race를 피할 수 있다
 
 MainActor를 선언하면 모든 동작이
 Main dispatch queue에서 이루어진다. 
 */
@MainActor
final class GlobalLoader: ObservableObject {
    @Published private(set) var model = GlobalLoadingModel()
    
    private var timer = Timer()
    static let shared = GlobalLoader()
    
    init() {
        timer.invalidate()
    }
    
    func addInTask() {
        Task {
            model.loadingCount += 1 
        }
    }
    
    func add() {
        model.loadingCount += 1
    }
    
    func down() {
        model.loadingCount -= 1
    }
}
