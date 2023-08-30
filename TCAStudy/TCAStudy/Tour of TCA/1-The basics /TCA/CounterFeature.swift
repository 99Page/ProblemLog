//
//  CounterFeature.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
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
    
    /*
     UnitTest를 진행하기 위해서 Equatable 채택 필요
     send에는 필요없지만 receive에 필요하다
     */
    enum Action: Equatable {
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
    
    //  의존성 주입이 필요할 때 PointFree에서 만든
    //  Dependency 라이브러리 사용
    //  테스트할 때 의존성을 설정해주지 않으면
    //  에러가 발생한다. 
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFactClient
    
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
                    try await clock.sleep(for: .seconds(2))
                    
                    // 클로저 내부에서 불가능
                    // mutate를 하고 싶다면 관련된 다른 action을 실행해야함
                    // state.fact = fact
                    // 이를 처리하기 위해서 factResponse action 생성
                    // await을 이용해서 호출해야함
                    try await send(.factResponse(numberFactClient.fetch(count)))
                }
            case .toggleTimerButtonTapped:
                state.isTimerOn.toggle()
                
                if state.isTimerOn {
                    return .run { send in
                        for await _ in clock.timer(interval: .seconds(1)) {
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
