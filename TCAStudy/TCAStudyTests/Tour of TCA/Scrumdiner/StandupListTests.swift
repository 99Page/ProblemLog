//
//  StandupListTests.swift
//  TCAStudyTests
//
//  Created by 노우영 on 2023/10/07.
//

import XCTest
import ComposableArchitecture
@testable import TCAStudy

@MainActor
final class StandupListTests: XCTestCase {
    
    func testAddButtonTapped() async {
        let store = TestStore(initialState: StandupsListFeature.State()) {
            StandupsListFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        //  exhaustivity를 사용하면 테스트하는 trailing closure에 mutate 결과를 작성하지 안하도 테스트에 성공한다 
        store.exhaustivity = .off
        
        var standup =  Standup(id: UUID(0),
                               attendees: [Attendee(id: UUID(1))]
        )
        
        await store.send(.addButtonTapped) {
            _ = $0
//            $0.addStandup = StandupFormFeature.State(
//                standup: standup)
        }
        
        standup.title = "Point-Free Morning Sync"
        await store.send(.addStandup(.presented(.set(\.$standup, standup)))) {
            $0.addStandup?.standup.title = "Point-Free Morning Sync"
        }
        
        await store.send(.saveStandupButtonTapped) {
            $0.addStandup = nil 
            $0.standups.append(standup)
        }
    }
}
