//
//  BasicsView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/29.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        static let maxCount = 10
        
        var count = 0
        var fact: String?
        var isTimerOn = false
        var isLoadingFact = false
        
        var isMax: Bool {
            count == CounterFeature.State.maxCount
        }
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case getFactButtonTapped
        case toggleTimerButtonTapped
        case factResponse(String)
        case timerTicking
    }
    
    private enum CancellID: Hashable {
        case timer
    }
    
    //  Reducer<State, Action>을 RecuerOf<Self>로 축약
    var body: some ReducerOf<Self> {
        
        //  Reduce는 Effect를 반환한다
        //  반환한 Effect를 사용해 다른 action 재호출 가능
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .getFactButtonTapped:
                state.fact = nil
                state.isLoadingFact = true
                return .run { [count = state.count] send in // 내부 state 값을 capture해야 read 가능
                    try await Task.sleep(for: .seconds(2))
                    let url = URL(string: "http://www.numbersapi.com/\(count)")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let fact = String(decoding: data, as: UTF8.self)
                    print(fact)
                    
                    // 클로저 내부에서 불가능
                    // mutate를 하고 싶다면 관련된 다른 action을 실행해야함
                    // state.fact = fact
                    // 이를 처리하기 위해서 factResponse action 생성
                    // await을 이용해서 호출해야함
                    await send(.factResponse(fact))
                }
            case .toggleTimerButtonTapped:
                state.isTimerOn.toggle()
                
                if state.isTimerOn {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTicking)
                        }
                    }
                    .cancellable(id: CancellID.timer) // 실행 중인 비동기 함수를 종료시키려면 cancellable 정의 필요
                } else {
                    return .cancel(id: CancellID.timer) // 비동기 함수 종료할 때 .cancel 및 동일할 hashable 값 호출
                }
        
            case let .factResponse(fact):
                state.fact = fact
                state.isLoadingFact = false
                return .none
                
            case .timerTicking:
                state.count += 1
                
                if state.isMax {
                    state.isTimerOn = false
                    return .cancel(id: CancellID.timer)
                } else {
                    return .none
                }
            }
        }
    }
}

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
