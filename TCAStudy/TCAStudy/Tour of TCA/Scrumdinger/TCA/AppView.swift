//
//  AppView.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/10/07.
//

import ComposableArchitecture
import SwiftUI


struct AppFeature: Reducer {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var standupList: StandupsListFeature.State = .init()
    }
    
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case standupList(StandupsListFeature.Action)
    }
    
    struct Path: Reducer {
        
        enum State: Equatable {
            case detail(StandupDetailFeature.State)
        }
        
        enum Action: Equatable {
            case detail(StandupDetailFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.detail, action: /Action.detail) {
                StandupDetailFeature()
            }
        }
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.standupList, action: /Action.standupList) {
            StandupsListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .path(.element(id: _,
                                    action: .detail(.delegate(action)))):
                
                switch action {
                case let .standupUpdate(standup):
                    // 디테일 뷰의 변경된 작업을 전체 리스트에서 쉽게 변경해줄 수 있는 것은 장점이다.
                    state.standupList.standups[id: standup.id] = standup
                    return .none
                }
                
            case .standupList(_):
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStackStore(
            store.scope(state: \.path,
                        action: { .path($0)
                        })
        ) {
            StandupsListView(
                store:
                    store.scope(state: \.standupList,
                                action: { .standupList($0) })
            )
        } destination: { state in
            switch state {
            case .detail:
                CaseLet(/AppFeature.Path.State.detail,
                         action: AppFeature.Path.Action.detail,
                         then: StandupDetailView.init(store:)
                )
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(initialState: AppFeature.State(
            standupList: .init(standups: [.mock])
        ), reducer: {
            AppFeature()
        }))
    }
}
