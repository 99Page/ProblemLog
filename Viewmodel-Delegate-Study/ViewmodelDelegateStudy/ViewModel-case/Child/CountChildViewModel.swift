//
//  ViewModelChildViewModel.swift
//  Viewmodel-Delegate-Study
//
//  Created by wooyoung on 2023/10/30.
//

import Foundation

protocol CountChildViewModel: ObservableObject {
    var childModel: CountChildModel{ get set }
    func onButtonTapped()
}

extension CountChildViewModel {
    func onButtonTapped() {
        childModel.value += 1
    }
}

final class NullViewModelChildViewModel: CountChildViewModel {
    var childModel: CountChildModel = .init()
}
