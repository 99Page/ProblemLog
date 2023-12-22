//
//  LoadingCallerModel.swift
//  GlobalLoading
//
//  Created by 노우영 on 12/17/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

struct LoadingCallerModel: Hashable {
    let text: String
    let shouldNavigateAfterLoading: Bool
    var isNavigated: Bool = false
    
    var shouldNavigate: Bool {
        shouldNavigateAfterLoading && !isNavigated
    }
}
