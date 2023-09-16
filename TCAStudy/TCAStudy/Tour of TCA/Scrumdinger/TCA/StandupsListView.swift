//
//  StandupsListView.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/09/16.
//

import ComposableArchitecture
import SwiftUI

struct StandupsListFeature: Reducer {
    struct State {
        var standups: IdentifiedArrayOf<Standup> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.standups.append(
                    Standup(id: UUID(), theme: .allCases.randomElement()!)
                )
                return .none
            }
        }
    }
}

struct StandupsListView: View {
    
    //  action을 보내고, 변경된 state를 관찰해주는 역할을 한다.
    let store: StoreOf<StandupsListFeature>
    
    var body: some View {
        
        // observe 오는 값은 관찰하려는 값이다.
        // $0을 이용해 모든 값을 관찰할 수도 있지만 keyPath로 특정 값을 지정하는게
        // 성능에 유리하다
        WithViewStore(store, observe: \.standups) { viewStore in
            List {
                ForEach(viewStore.state) { standup in
                    CardView(standup: standup)
                        .listRowBackground(standup.theme.mainColor)
                }
            }
            .navigationTitle("Standups")
            .toolbar {
                ToolbarItem {
                    Button("add") {
                        viewStore.send(.addButtonTapped)
                    }
                }
            }
        }
    }
}

struct StandupsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandupsListView(store: Store(initialState: StandupsListFeature.State(standups: [.mock]), reducer: {
                StandupsListFeature()
            }))
        }
    }
}
