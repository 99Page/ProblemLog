//
//  ChildModel.swift
//  BindingConventionStudy
//
//  Created by wooyoung on 2023/11/01.
//

import Foundation

protocol ChildViewModel: ObservableObject {
    var value: Int { get set }
}

extension ChildViewModel {
    func onButtonTapped() {
        value = 0
    }
}
