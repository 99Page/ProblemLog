//
//  YellowHeartViewmodel.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
import SwiftUI

final class YellowHeartViewmodel: ObservableObject {
    @Published var likeViewmodel: LikeViewmodel
    
    init() {
        likeViewmodel = LikeViewmodel(heartColor: .yellow,
                                      likeButtonTapped: {
            debugPrint("Yellow heart button tapped")
        })
    }
}

final class RedHeartViewmodel: ObservableObject {
    @Published var likeVimewodel: LikeViewmodel
    
    init() {
        likeVimewodel = LikeViewmodel(heartColor: .red,
                                      likeButtonTapped: {
            debugPrint("Red heart button tapped")
        })
    }
}
