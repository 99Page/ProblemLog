//
//  TCAStudyApp.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCAStudyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
        }
    }
}
