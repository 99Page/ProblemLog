//
//  Test.swift
//  GlobalLoadingTest
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import XCTest
@testable import GlobalLoading

final class Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainActorViewModel() async throws {
        let viewModelForRaceCondition = await GlobalLoader()
        let viewModel = await GlobalLoader()
        
        for _ in 0..<100 {
            await viewModelForRaceCondition.addInTask()
        }
        
        for _ in 0..<100 {
            await viewModel.add()
        }
        
        do {
            try await Task.sleep(for: .seconds(2))
            /*
             model 타입을 actor로 하지 말고 viewmodel을 @MainActor로 선언해야한다.
             메인 쓰레드에서 값 변화를 관찰 후 UI로 렌더링 해야해서 MainActor를 써야한다.
             그리고 이렇게 한 경우, 뷰에서는 비동기 과정없이 접근할 수 있다.
             테스트해보면 Thread safety한 것이 확인 가능하다. 
             */
            debugPrint("mode value: \(await viewModelForRaceCondition.model.loadingCount)")
            
            /*
             반면에 모두 같은 쓰레드에서 실행될 경우 값이 일정하다. 
             */
            debugPrint("model valeu: \(await viewModel.model.loadingCount)")
        } catch {
            
        }
    }
    
    func testPartially() async {
        let viewModel = LocalLoadingViewModel(shouldNavigateAfterLoading: false)
        let viewModelForMainActorFunction = LocalLoadingViewModel(shouldNavigateAfterLoading: false)
        
        /**
         멀티 쓰레드에서 같은 뷰모델에 있는 값을 업데이트하면 결과가 어떻게 나올까?
         */
        for _ in 0..<1000 {
            viewModel.add()
        }
        
        
        for _ in 0..<1000 {
            viewModelForMainActorFunction.addInMainActor()
        }
        
        do {
            try await Task.sleep(for: .seconds(2))
            /**
             값이 정상적으로 업데이트 되지 않는다.
             */
            debugPrint("non main actor: \(viewModel.model.count)")
            
            /*
             Class에 MainActor를 선언하지 않고
             함수에 MainActor를 선언해도 data race를 피할 수 있다. 
             */
            debugPrint("main actor function: \(viewModelForMainActorFunction.model.count)")
        } catch {
            
        }
    }
}
