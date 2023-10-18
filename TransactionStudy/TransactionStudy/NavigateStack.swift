//
//  NavigateStack.swift
//  TransactionStudy
//
//  Created by wooyoung on 2023/10/17.
//

import Foundation

final class NavigateStack: ObservableObject {
    static let shared = NavigateStack()
    
    @Published var paths: [Int] = []
}
