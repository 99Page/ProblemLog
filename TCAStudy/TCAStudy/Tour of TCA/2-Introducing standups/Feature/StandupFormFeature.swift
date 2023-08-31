//
//  StandupFormView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import ComposableArchitecture
import Foundation

struct StandupFormFeature: Reducer {
    
    struct State: Equatable {
        @BindingState var field: Field?
        @BindingState var standup: Standup
        
        enum Field: Hashable {
            case attendee(Attendee.ID)
            case title
        }
    }
    
    enum Action: BindableAction {
        //  기존에는 set, get을 분리했는데 BindingAction으로 $ 이용해서 깔끔하게 이용 가능
        case binding(BindingAction<State>)
        case addAttendeeButtonTapped
        case deleteAttendee(atOffsets: IndexSet)
    }
    
    //  테스트 시 원하는 uuid 값을 설정하기 위해서
    //  uuidGenerator는 의존성 주입이 필요하다 
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        //  Binding 필요한 경우 선언
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .deleteAttendee(let atOffsets):
                state.standup.attendees.remove(atOffsets: atOffsets)
                
                if state.standup.attendees.isEmpty {
                    state.standup.attendees.append(Attendee(id: uuid()))
                }
                
                guard let firstIndex = atOffsets.first else { return .none }
                let index = min(firstIndex, state.standup.attendees.count - 1)
                state.field = .attendee(state.standup.attendees[index].id)
                
                return .none
            case .addAttendeeButtonTapped:
                let attendee = Attendee(id: uuid())
                state.standup.attendees.append(attendee)
                state.field = .attendee(attendee.id)
                return .none
            }
        }
    }
}

extension Duration {
  var minutes: Double {
    get { Double(self.components.seconds / 60) }
    set { self = .seconds(newValue * 60) }
  }
}
