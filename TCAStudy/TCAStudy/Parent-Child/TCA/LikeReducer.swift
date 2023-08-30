//
//  LikeStore.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct LikeReducer: Reducer {
    
    struct State: Equatable {
        var heartColor: Color
    }
    
    enum Action: Equatable {
        case heartButtonTapped(Color)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .heartButtonTapped(color):
                //  Delegate를 하기 위해서는 상위 뷰에서 기능을 지정. 이곳에서는 아무것도 하지 않음
                debugPrint("child button tapped")
                return .none
            }
        }
    }
}
