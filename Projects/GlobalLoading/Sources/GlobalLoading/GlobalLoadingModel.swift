//
//  SimpleModel.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

struct GlobalLoadingModel {
    var loadingCount: Int = 0
    private let originContentTrigger = 0
    
    var isLoadingViewRequired: Bool {
        loadingCount != originContentTrigger
    }
}
