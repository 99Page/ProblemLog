//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 12/13/23.
//

import SwiftUI

@main
struct GlobalLoadingApp: App {
    
    @StateObject private var navigator = Navigator.shared
    @StateObject private var globalLoader = GlobalLoader.shared
    
    var body: some Scene {
        WindowGroup {
            NavigateView()
                .environmentObject(globalLoader)
                .environmentObject(navigator)
        }
    }
}
