//
//  ViewModelParentViewModel.swift
//  Viewmodel-Delegate-Study
//
//  Created by wooyoung on 2023/10/30.
//

import Foundation

final class CountParentViewModel: CountChildViewModel {
    @Published var isSheetPresented: Bool = false
    @Published var childModel: CountChildModel = .init()
    
    func onPresentSheetButtonTapped() {
        isSheetPresented = true
    }
}
