//
//  PartiallyLoadingModel.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

struct LocalLoadingModel: Hashable {
    var isLoading: Bool = true
    var count: Int = 0
    var shouldNavigateAfterLoading: Bool
}
