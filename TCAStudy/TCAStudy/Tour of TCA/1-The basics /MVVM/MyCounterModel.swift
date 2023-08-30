//
//  MyCounterModel.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation

struct MyCounterModel {
    static let maxCount = 10
    
    var count = 0
    var fact: String?
    var isTimerOn = false
    var isLoadingFact = false
    
    var isMax: Bool {
        count == Self.maxCount
    }
    
    var timerText: String {
        isTimerOn ? "Stop timer" : "Start timer"
    }
}
