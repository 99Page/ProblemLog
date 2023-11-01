//
//  ComponentViewModel.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import Foundation

protocol ComponentViewModel: ObservableObject {
    associatedtype Model: ComponentModel
    var componentModel: Model { get set }
    func onButtonTapped()
}

extension ComponentViewModel {
    func onButtonTapped() {
        componentModel.value += 1 
    }
}
