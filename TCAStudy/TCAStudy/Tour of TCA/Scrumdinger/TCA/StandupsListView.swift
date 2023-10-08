//
//  StandupsListView.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/09/16.
//

import ComposableArchitecture
import SwiftUI

struct StandupsListFeature: Reducer {
    
    // MVVM에서 @Published를 사용하는 부분이 State와 매칭된다.
    // 나는 @Published를 한개만 선언하는데 이곳에서는 여러개를 선언한다는 차이점이 있다
    struct State: Equatable {
        @PresentationState var addStandup: StandupFormFeature.State?
        var standups: IdentifiedArrayOf<Standup> = []
    }
    
    enum Action: Equatable {
        case addButtonTapped
        
        // 하위로 전달한 Action의 동작이 실행된 후 나중에 실행된다.
        // Delegate 패턴이 필요할 때 유용하다
        case addStandup(PresentationAction<StandupFormFeature.Action>)
        case cancelStandupButtonTapped
        case saveStandupButtonTapped
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addStandup = StandupFormFeature.State(standup: Standup(id: uuid()))
                return .none
                
            case .addStandup(_):
                return .none
                
            case .cancelStandupButtonTapped:
                state.addStandup = nil
                return .none
                
            case .saveStandupButtonTapped:
                guard let addStandup = state.addStandup?.standup
                else { return .none }
                
                state.standups.append(addStandup)
                state.addStandup = nil
                return .none
            }
        }
        .ifLet(\.$addStandup, action: /Action.addStandup) {
            StandupFormFeature()
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
                    NavigationLink(
                        state: AppFeature.Path.State.detail(StandupDetailFeature.State(standup: standup))
                    ) {
                        CardView(standup: standup)
                            .listRowBackground(standup.theme.mainColor)
                    }
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
            .sheet(store: store.scope(state: \.$addStandup,
                                      action: { .addStandup($0) })
            ) { store in
                NavigationStack {
                    StandupFormView(store: store)
                        .navigationTitle("New standup")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    viewStore.send(.saveStandupButtonTapped)
                                } label: {
                                    Text("save")
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    viewStore.send(.cancelStandupButtonTapped)
                                } label: {
                                    Text("cancel")
                                }
                            }
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
