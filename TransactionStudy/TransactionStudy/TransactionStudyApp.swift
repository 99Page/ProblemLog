//
//  TransactionStudyApp.swift
//  TransactionStudy
//
//  Created by wooyoung on 2023/10/17.
//

import SwiftUI

@main
struct TransactionStudyApp: App {
    
    @StateObject private var viewModel = NavigateStack.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
