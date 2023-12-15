//
//  CustomPath.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

enum CustomPath: Hashable {
    case loadingCaller(LoadingCallerModel)
    case partiallyLoading(LocalLoadingModel)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .loadingCaller(let model):
            LoadingCallerView(model: model)
        case .partiallyLoading(let localLoadingModel):
            LocalLoadingView(localLoadingModel)
        }
    }
}
