//
//  Counter.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

/*
 TCA를 사용하는 가장 기본적인 형태
 */
struct Counter: Reducer {
    
    // View에서 사용할 상태를 정의합니다.
    struct State: Equatable {
        var count = 0
        
        var isHidden: Bool {
            count <= -5
        }
    }
    
    //  View에서 사용할 기능을 정의합니다.
    //  스크린을 통한 상호작용이나, onAppear 등 뷰의 생명주기 관련 상호작용이 해당 합니다.
    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}

struct CounterView: View {
    
    let store: StoreOf<Counter>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                
                if !viewStore.isHidden {
                    Button {
                        viewStore.send(.decrementButtonTapped)
                    } label: {
                        Image(systemName: "minus")
                    }
                }
                
                Text("\(viewStore.count)")
                    .monospacedDigit()

                Button {
                    viewStore.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }

    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: Store(initialState: Counter.State(), reducer: {
            Counter()
        }))
    }
}
