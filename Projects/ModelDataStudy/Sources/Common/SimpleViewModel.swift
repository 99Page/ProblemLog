//
//  SimpleViewModel.swift
//  ModelDataStudy
//
//  Created by wooyoung on 2023/11/29.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class SimpleViewModel: ObservableObject {
    @Published var value: Int = 0
    
    func onButtonTapped() {
        value += 1 
    }
}
