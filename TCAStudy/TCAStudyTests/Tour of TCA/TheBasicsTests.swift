//
//  TheBasicsTests.swift
//  TCAStudyTests
//
//  Created by wooyoung on 2023/08/30.
//

import XCTest
import ComposableArchitecture
@testable import TCAStudy

@MainActor
final class TheBasicsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //  MVVM에서 메소드를 테스트한거처럼 TCA에서는 Action을 테스트
    //  모든 action은 비동기 메소드
    //  따라서 모든 test는 async
    func test_IncrementButtonTapped() async {
        
        let repeatCount: Int = .random(in: 1..<100)
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        //  stress test
        for i in 1...repeatCount {
            await store.send(.incrementButtonTapped, assert: { state in
                //  내부에 테스트할 내용이 들어간다.
                state.count = i
            })
        }
    }
    
    func test_DecrementButtonTapped() async {
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        let expected = store.state.count - 1
        
        await store.send(.decrementButtonTapped, assert: { state in
            state.count = expected
        })
    }
    
    func test_ToggleTimerButtonTapped() async throws {
        
        /*
         Task로 시간을 설정하면 실제 동작하는 코드와 테스트에서 기다리는 Task의 시간이 공유되지 않는다.
         Clock을 사용해서 양쪽의 동기를 맞춰줄 수 있다.
         */
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        /*
         toggleTimerButtonTapped를 호출하면 내부에서
         timerTicking Action을 실행한다.
         모든 테스트는 실행되고 있는 Action이 종료되어야 하는데
         toggleTimerButtonTapped를 한번만 호출하면 Action이 여전히 실행중이여서
         테스트에 실패한다.
         */
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = true
        }
        
        await clock.advance(by: .seconds(1))
        
        //  호출된 모든 Action은 테스트되어야 한다.
        //  timcerTicking은 toggleTimerButtonTapped를 통해서 호출된다. 
        await store.receive(.timerTicking) {
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = false
        }
    }
    
    func test_getFactButtonTapped() async {
        
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            // 모든 테스트마다 이런식으로 기능을 정의해줘야 하는건 코드의 중복이 생긴다.
            // 테스트 하는 경우에는 protocol이 더 적합해 보인다.
            $0.numberFact = NumberFactCliet { "count \($0)" }
            //  ImmerdiateClock 사용하지 않으면 내부에서 계속 Clock이 동작하면서
            //  Action이 실행된 상태가 된다.
            $0.continuousClock = ImmediateClock()
        }
        
        await store.send(.getFactButtonTapped) {
            $0.isLoadingFact = true
        }
        
        await store.receive(.factResponse("count 0")) {
            $0.fact = "count 0"
            $0.isLoadingFact = false
        }
    }
}
