//
//  StandupListView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import SwiftUI
import ComposableArchitecture

struct StandupListView: View {
    
    let store: StoreOf<StandupListFeature>
    
    var body: some View {
        
        //  관찰하려는 State만 \. 를 이용해서 지정해줄 수 있다.
        //  $0 하는 것보다 성능에 유리
        WithViewStore(store, observe: \.standups) { viewStore in
            List {
                ForEach(viewStore.state) { stanup in
                    StandupView(standup: stanup)
                        .listRowBackground(stanup.theme.mainColor)
                }
            }
            .navigationTitle("Daily standups")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        viewStore.send(.addStandupButtonTapped)
                    }
                }
            }
        }
    }
}


struct StandupListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandupListView(
                store: Store(initialState: StandupListFeature.State(standups: [.mock()]),
                             reducer: { StandupListFeature() }
                            )
            )
        }
    }
}
