//
//  StanupListFeature.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import Foundation
import ComposableArchitecture

struct StandupListFeature: Reducer {
    
    struct State {
        var standups: IdentifiedArrayOf<Standup>
    }
    
    enum Action {
        case addStandupButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addStandupButtonTapped:
                let standup = Standup(theme: .allCases.randomElement()!,
                                      title: "Daily scrum")
                state.standups.append(standup)
                return .none
            }
        }
    }
}
 
