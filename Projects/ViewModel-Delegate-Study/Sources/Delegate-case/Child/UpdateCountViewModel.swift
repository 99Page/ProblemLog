//
//  UpdateCountViewModel.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import Foundation

final class UpdateCountViewModel: ObservableObject {
    @Published var model = UpdateCountModel()
    
    private let delegate: UpdateCountDelegate
    
    init(delegate: UpdateCountDelegate) {
        self.delegate = delegate
    }
    
    func onUpdateButtonTapped() {
        model.count += 1 
        delegate.didTapUpdateButton()
    }
}
