//
//  MyCounterViewmodel.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
import SwiftUI
import ComposableArchitecture

final class MyCounterViewmodel: ObservableObject {
    @Published private(set) var myCounterModel = MyCounterModel()
    @Dependency(\.continuousClock) var clock 
    
    private let numberFactService: MyNumberFactServiceProtocol
    
    init(numberFactService: MyNumberFactServiceProtocol) {
        self.numberFactService = numberFactService
    }
    
    func onDecementedButtonTapped() {
        myCounterModel.count -= 1
        myCounterModel.fact = nil
    }
    
    func onIncrementButtonTapped() {
        myCounterModel.count += 1
        myCounterModel.fact = nil
    }
    
    func onToggleTimerButtonTapped() async {
        myCounterModel.isTimerOn.toggle()
        
        for await _ in clock.timer(interval: .seconds(1)) {
            guard myCounterModel.isTimerOn else { return }
            await timerTicking()
        }
    }
    
    @MainActor
    func onGetFactButtonTapped() async {
        defer {
            myCounterModel.isLoadingFact = false
        }
        
        myCounterModel.isLoadingFact = true
        myCounterModel.fact = nil
        
        let result = try? await numberFactService.fetch(myCounterModel.count)
        
        guard let fact = result else { return }
        onFetchSuccess(fact)
    }
    
    
    //  TCA의 action과 달리 View에 불필요한 기능을 숨길 수 있다.
    @MainActor
    private func onFetchSuccess(_ fact: String?) {
        myCounterModel.fact = fact
    }
    
    @MainActor
    private func timerTicking() {
        myCounterModel.count += 1
        
        if myCounterModel.isMax {
            myCounterModel.isTimerOn = false
        }
    }
}
