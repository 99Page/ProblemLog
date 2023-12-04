//
//  PaginationState.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct PaginationModel {
    var fetchTriggerOffset: CGFloat = .zero
    var state: PaginationState = .wait
    
    var isFetchEnabeld: Bool {
        isFetchTriggerInScreen && state == .wait
    }
    
    var isFetchTriggerInScreen: Bool {
        fetchTriggerOffset <= UIScreen.main.bounds.maxY
    }
}

extension PaginationModel {
    enum PaginationState: Equatable {
        case wait
        case loading
    }
}
