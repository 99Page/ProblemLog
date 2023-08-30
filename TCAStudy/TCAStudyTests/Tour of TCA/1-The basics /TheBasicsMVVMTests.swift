//
//  TheBasicsMVVMTests.swift
//  TCAStudyTests
//
//  Created by wooyoung on 2023/08/30.
//

import XCTest
import Combine
import ComposableArchitecture
@testable import TCAStudy

final class TheBasicsMVVMTests: XCTestCase {
    
    var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_IncrementButtonTapped() {
        //  given
        let repeatCount: Int = .random(in: 1..<100)
        
        let viewmodel = MyCounterViewmodel(numberFactService: MyNumberFactStubService())
        
        //  when
        for _ in 0..<repeatCount {
            viewmodel.onIncrementButtonTapped()
        }
        
        //  then
        let expected = repeatCount
        XCTAssertEqual(viewmodel.myCounterModel.count, expected)
    }
    
    func test_DecementButtonTapped() {
        //  given
        let repeatCount: Int = .random(in: 1..<100)
        let viewmodel = MyCounterViewmodel(numberFactService: MyNumberFactStubService())
        
        //  when
        for _ in 0..<repeatCount {
            viewmodel.onDecementedButtonTapped()
        }
        
        //  then
        let expected = -repeatCount
        XCTAssertEqual(viewmodel.myCounterModel.count, expected)
    }
    
    func test_GetFactButtonTapped() async throws {
        //  given
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 4
        var fulfillmentCount: Int = 0
        
        let service = MyNumberFactStubService()
        let viewmodel = MyCounterViewmodel(numberFactService: service)
        
        //  when
        let expectedFact: String = try await service.fetch(0)
        viewmodel.$myCounterModel
            .dropFirst()
            .sink { model in
                fulfillmentCount += 1
                expectation.fulfill()
                debugPrint("\(model)")
                
                switch fulfillmentCount {
                case 1:
                    XCTAssertEqual(model.isLoadingFact, true)
                case 2:
                    XCTAssertEqual(model.fact, nil)
                    
                //  case 3, 4는 onGetFactButtonTapped에서 호출 하는 onFetchSuccess의 테스트인데
                //  MVVM에서는 이를 분리하기가 어렵다.
                //  기존에는 최종적인 결과만 테스트했기때문에 함수 하나하나에 따른 변화를 확인하지는 않았음.
                    
                //  값이 변하는 순서에 따라 매우 깨지기 쉬운 테스트.
                case 3:
                    XCTAssertEqual(model.fact, expectedFact)
                case 4:
                    XCTAssertEqual(model.isLoadingFact, false)
                default:
                    XCTFail("값은 4번만 변경되어야 한다. ")
                }
            }
            .store(in: &cancellable)
        
        await viewmodel.onGetFactButtonTapped()
    }
}
