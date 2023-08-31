//
//  StandupFormsTests.swift
//  TCAStudyTests
//
//  Created by wooyoung on 2023/08/31.
//

import XCTest
import ComposableArchitecture
@testable import TCAStudy

@MainActor
final class StandupFormsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddDeleteAttendee() async {
        let store = TestStore(initialState: StandupFormFeature.State(standup: .mock())) {
            StandupFormFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        //  UUID값은 랜덤하게 생성되는데 TCA에서 테스트는 정확한 값을 확인하려고 한다.
        //  따라서 UUID값을 내가 조정할 수 있어야하고
        //  이를 위해서 UUID도 @Dependency를 이용해서 주입시킨다. 
        await store.send(.addAttendeeButtonTapped) {
            $0.field = .attendee(UUID(0))
            $0.standup.attendees.append(Attendee(id: UUID(0)))
        }
        
        await store.send(.addAttendeeButtonTapped) {
            $0.field = .attendee(UUID(1))
            $0.standup.attendees.append(Attendee(id: UUID(1)))
        }
        
        await store.send(.deleteAttendee(atOffsets: [1])) {
            $0.field = .attendee($0.standup.attendees[0].id)
            $0.standup.attendees.remove(at: 1)
        }
    }

}
