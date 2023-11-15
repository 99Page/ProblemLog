//
//  DelegateChildViewModel.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import Foundation

protocol UpdateCountDelegate {
    func didTapUpdateButton() 
}

final class NullUpdateCountDelegate: UpdateCountDelegate {
    func didTapUpdateButton() {
        
    }
}
