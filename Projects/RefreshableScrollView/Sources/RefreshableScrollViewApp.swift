//
//  App.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/4/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

@main
struct RefreshableScrollViewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    NavigationLink("Vanila") {
                        VanilaRefreshableView()
                    }
                    
                    NavigationLink("Refreshable scroll view") {
                        ColorView()
                    }
                    
                    NavigationLink("Refreshable paginated scroll view") {
                        GrowingColorView()
                    }
                }
            }
        }
    }
}

