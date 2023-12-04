//
//  RefreshableScrollViewModel.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class RefreshableScrollViewModel: ObservableObject {
    @Published var model: RefreshableScrollModel
    
    init(refreshThreshold: CGFloat) {
        self.model = .init(refreshThreshold: refreshThreshold)
    }
}
