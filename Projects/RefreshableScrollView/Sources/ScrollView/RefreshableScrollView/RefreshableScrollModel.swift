//
//  RefreshableScrollModel.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct RefreshableScrollModel {
    var scrollOffset: CGFloat = .zero
    var dragVelocity: CGFloat = .zero
    var refreshThreshold: CGFloat
    
    var rotatingDegree: Double {
        Double(scrollOffset) * 4
    }
    
    var componentOpacity: CGFloat {
        scrollOffset - refreshThreshold
    }
    
    var opacity: CGFloat {
        scrollOffset - refreshThreshold
    }
    
    var isRefreshEnabled: Bool {
        scrollOffset > refreshThreshold && dragVelocity <= 0
    }
    
}
