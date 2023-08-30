//
//  BasicsView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/29.
//

import SwiftUI
import ComposableArchitecture

struct BasicsView: View {
    
    //  Store<CounterFeature.State, CounterFeautre.Action> 축약
    
    let store: StoreOf<CounterFeature>
    
    
    var body: some View {
        // store를 관찰하려면 WithViewStore 선언 필요
        // 모든 값을 관찰하기 위해 $0 그대로 이용
        
        // 추후 버전에서는 WithViewStore 사라지는듯..?
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Text("\(viewStore.count)")
                    
                    Button("Decrement") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    
                    Button("Increment") {
                        viewStore.send(.incrementButtonTapped)
                    }
                }
                
                Section {
                    HStack {
                        Button("Get fact") {
                            viewStore.send(.getFactButtonTapped)
                        }
                        
                        if viewStore.isLoadingFact {
                            Spacer()
                            ProgressView()
                        }
                    }
                    
                    if let fact = viewStore.fact {
                        Text(fact)
                    }
                }
                
                Section {
                    if viewStore.isTimerOn {
                        Button("Stop timer") {
                            viewStore.send(.toggleTimerButtonTapped)
                        }
                    } else {
                        Button("Start timer") {
                            viewStore.send(.toggleTimerButtonTapped)
                        }
                    }
                }
            }
        }
    }
}
struct BasicsView_Previews: PreviewProvider {
    static var previews: some View {
        BasicsView(store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
                ._printChanges() //  모든 값의 변화를 출력해준다.
        })
    }
}
