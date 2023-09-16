//
//  StandupFormTests.swift
//  TCAStudyTests
//
//  Created by 노우영 on 2023/09/16.
//

import XCTest
import ComposableArchitecture
@testable import TCAStudy

@MainActor
final class StandupFormTests: XCTestCase {

    func testAddButtonTapped() async {
        let store = TestStore(initialState: StandupFormFeature.State(
            standup: Standup(id: UUID(),
                            attendees: [
                                Attendee(id: UUID())
                            ]))
        ) {
            StandupFormFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addAttendeeButtonTapped) { 
            // 클로저 내부에는 예상되는 동작이 들어간다.
            // 아래 코드는 UUID가 달라서 실패한다.
            // $0.standup.attendees.append(Attendee(id: UUID()))
            
            $0.focus = .attendee(UUID(0))
            $0.standup.attendees.append(Attendee(id: UUID(0)))
        }
        
        await store.send(.deleteAttendee(atOffsets: [1])) {
            $0.focus = .attendee($0.standup.attendees[0].id)
            $0.standup.attendees.remove(at: 1)
        }
    }

}
