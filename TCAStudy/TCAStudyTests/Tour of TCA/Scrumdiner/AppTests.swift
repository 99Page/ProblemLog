//
//  AppTests.swift
//  TCAStudyTests
//
//  Created by 노우영 on 2023/10/07.
//

import ComposableArchitecture
import XCTest
@testable import TCAStudy

@MainActor
final class AppTests: XCTestCase {
    
    func testEdit() async {
        let standup = Standup.mock
        let store = TestStore(initialState: AppFeature.State(
            standupList: StandupsListFeature.State(standups: [standup]))
        ) {
            AppFeature()
        }
        
        await store.send(.path(.push(id: 0, state: .detail(StandupDetailFeature.State(standup: standup))))) {
            $0.path[id: 0] = .detail(StandupDetailFeature.State(standup: standup))
        }
        
        await store.send(.path(.element(id: 0, action: .detail(.editButtonTapped)))) {
            $0.path[id: 0, case: /AppFeature.Path.State.detail]?.editStandup = StandupFormFeature.State(standup: standup)
        }
        
        var editedStandup = standup
        editedStandup.title = "Point Free Morning Sync"
        
        await store.send(.path(.element(id: 0, action: .detail(.editStandup(.presented(.set(\.$standup, editedStandup))))))) {
            $0.path[id: 0, case: /AppFeature.Path.State.detail]?.editStandup?.standup.title = editedStandup.title
        }
        
        await store.send(.path(.element(id: 0, action: .detail(.saveStandupButtonTapped)))) {
            $0.path[id: 0, case: /AppFeature.Path.State.detail]?.editStandup = nil
            $0.path[id: 0, case: /AppFeature.Path.State.detail]?.standup.title = editedStandup.title
        }
        
        await store.receive(.path(.element(id: 0, action: .detail(.delegate(.standupUpdate(editedStandup)))))) {
            $0.standupList.standups[0].title = editedStandup.title
        }
    }
    
    func testEdit_NonExhaustive() async {
        let standup = Standup.mock
        let store = TestStore(initialState: AppFeature.State(
            standupList: StandupsListFeature.State(standups: [standup]))
        ) {
            AppFeature()
        }
        store.exhaustivity = .off
        
        await store.send(.path(.push(id: 0, state: .detail(StandupDetailFeature.State(standup: standup)))))
        await store.send(.path(.element(id: 0, action: .detail(.editButtonTapped))))
        
        var editedStandup = standup
        editedStandup.title = "Point Free Morning Sync"
        
        await store.send(.path(.element(id: 0, action: .detail(.editStandup(.presented(.set(\.$standup, editedStandup)))))))
        
        await store.send(.path(.element(id: 0, action: .detail(.saveStandupButtonTapped))))
        
        //  exhaustivity off를 할 경우 send로 보낸 액션은 스킵하지 않으면 테스트가 틀려도 옳게 처리된다. 
        await store.skipReceivedActions()
        
        store.assert {
            $0.standupList.standups[0].title = editedStandup.title
        }
    }
}
