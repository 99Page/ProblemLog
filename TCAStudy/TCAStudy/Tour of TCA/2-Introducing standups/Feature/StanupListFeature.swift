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
        @PresentationState var addStandup: StandupFormFeature.State?
        var standups: IdentifiedArrayOf<Standup>
    }
    
    enum Action {
        case addStandup(PresentationAction<StandupFormFeature.Action>)
        case addStandupButtonTapped
        case cancelStandupButtonTapped
        case saveStandupButtonTapped
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addStandupButtonTapped:
                state.addStandup = StandupFormFeature.State(standup: Standup(theme: .blue, title: "title"))
                return .none
            case .addStandup(_):
                return .none
            case .cancelStandupButtonTapped:
                state.addStandup = nil
                return .none
            case .saveStandupButtonTapped:
                guard let standup = state.addStandup?.standup
                else { return .none }
                state.standups.append(standup)
                state.addStandup = nil
                return .none
            }
        }
        .ifLet(\.$addStandup, action: /Action.addStandup) {
            StandupFormFeature()
        }
    }
}
 
