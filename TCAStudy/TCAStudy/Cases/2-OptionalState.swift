//
//  OptionalState.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

struct OptionalBasics: Reducer {
    
    struct State: Equatable {
        var optionalCounter: Counter.State?
    }
    
    enum Action: Equatable {
        case optionalCounter(Counter.Action)
        case toggleCounterButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleCounterButtonTapped:
                state.optionalCounter = state.optionalCounter == nil ? Counter.State() : nil
                return .none
                
            case .optionalCounter:
                return .none
            }
        }
        //  ifLet으로 사용하는게 아래와 동일하면 Counter를 반환한다?
        //  관련 코드는 line 53에
        .ifLet(\.optionalCounter, action: /Action.optionalCounter) {
            Counter()
        }
    }
}

struct OptionalBasicsView: View {
    
    let store: StoreOf<OptionalBasics>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
           
            Button("Toggle counter state") {
                viewStore.send(.toggleCounterButtonTapped)
            }
            
            //  IfLetStore를 이용해서 처리 
            IfLetStore(
              self.store.scope(
                state: \.optionalCounter,
                action: OptionalBasics.Action.optionalCounter
              ),
              then: { store in
                Text("`CounterState` is non-`nil`")
                CounterView(store: store)
                  .buttonStyle(.borderless)
                  .frame(maxWidth: .infinity)
              },
              else: {
                Text("`CounterState` is `nil`")
              }
            )

        }
    }
}

//struct OptionalState_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionalState()
//    }
//}
