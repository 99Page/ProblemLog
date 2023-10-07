//
//  StandupDetailTests.swift
//  TCAStudyTests
//
//  Created by 노우영 on 2023/10/07.
//

import ComposableArchitecture
import XCTest
@testable import TCAStudy

@MainActor
final class StandupDetailTests: XCTestCase {
    
    func testEdit() async {
        var standup = Standup.mock
        let store = TestStore(initialState: StandupDetailFeature.State(standup: standup)) {
            StandupDetailFeature()
        }

        await store.send(.editButtonTapped) {
            $0.editStandup = StandupFormFeature.State(standup: standup)
        }
        
        standup.title = "Point-Free Morning Sync"
        await store.send(.editStandup(.presented(.set(\.$standup, standup)))) {
            $0.editStandup?.standup.title = "Point-Free Morning Sync"
        }
        
        await store.send(.saveStandupButtonTapped) {
            $0.editStandup = nil 
            $0.standup.title = "Point-Free Morning Sync"
        }
    }
}
