//
//  StandupFomrView.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/09/16.
//

import ComposableArchitecture
import SwiftUI

/*
 Vanila는 ObservableObject가 class type인 반면
 Composable architecture는 모두 struct 타입이다
 */
struct StandupFormFeature: Reducer {
    struct State: Equatable {
        /*
         기존에는 바인딩을 위해서 Action에 setter를 만들어줘야했다.
         BindingState, BindingAction 같은 프로퍼티 래퍼를 사용해서 Binding을 편하게 할 수 있다.
         */
        @BindingState var standup: Standup
        @BindingState var focus: Field?
        
        init(focus: Field? = nil, standup: Standup) {
            self.focus = focus
            self.standup = standup
            
            @Dependency(\.uuid) var uuid
            
            if self.standup.attendees.isEmpty {
                self.standup.attendees.append(Attendee(id: uuid()))
            }
        }
        
        enum Field: Hashable {
            /*
             참여자를 추가할 때 자동으로 focus를 한다.
             참여자를 구분해야하니 associatedValue로 만들어진 참여자의 ID를 사용한다.
             */
            case attendee(Attendee.ID)
            case title
        }
    }
    
    enum Action: BindableAction, Equatable {
        case addAttendeeButtonTapped
        case binding(BindingAction<State>)
        case deleteAttendee(atOffsets: IndexSet)
        
    }
    
    // 테스트 시에 uuid 값이 동일해야한다.
    // uuid 값을 동일하게 해주기 위해서 의존성을 주입할 수 있는 uuid를 만든다 
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        // 아래 binding이 먼저 동작하고 Reduce가 동작한다.
        
        BindingReducer()
         
        Reduce { state, action in
            switch action {
            case .addAttendeeButtonTapped:
                let id = uuid()
                state.standup.attendees.append(Attendee(id: id))
                state.focus = .attendee(id)
                return .none
            case .binding(_):
                return .none
            case let .deleteAttendee(indicies):
                state.standup.attendees.remove(atOffsets: indicies)
                
                if state.standup.attendees.isEmpty {
                    state.standup.attendees.append(Attendee(id: uuid()))
                }
                
                guard let firstIndex = indicies.first
                else { return .none }
                
                let index = min(firstIndex, state.standup.attendees.count - 1)
                state.focus = .attendee(state.standup.attendees[index].id)
                return .none
            }
        }
    }
}

struct StandupFormView: View {
    
    let store: StoreOf<StandupFormFeature>
    @FocusState var focus: StandupFormFeature.State.Field?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    TextField("Title", text: viewStore.$standup.title)
                        .focused($focus, equals: .title)
                    HStack {
                        Slider(value: viewStore.$standup.duration.minutes, in: 5...30, step: 1) {
                            Text("Length")
                        }
                        
                        Spacer()
                        
                        Text("\(viewStore.standup.duration.formatted(.units()))")
                    }
                    ThemePicker(selection: viewStore.$standup.theme)
                } header: {
                    Text("Standup info")
                }
                
                Section {
                    ForEach(viewStore.$standup.attendees) { $attendee in
                        TextField("name", text: $attendee.name)
                            .focused($focus, equals: .attendee(attendee.id))
                    }
                    .onDelete { index in
                        viewStore.send(.deleteAttendee(atOffsets: index))
                    }
                    
                    Button("Add attendee") {
                        viewStore.send(.addAttendeeButtonTapped)
                    }
                } header: {
                    Text("Attendees")
                }
            }
            // 이 Modifier를 사용해서 양쪽의 값을 synchronize 할 수 있다.
            // focus를 사용할 때 유용하고 구현이 어렵진 않으니 본 프로젝트에서 해도 좋을 듯
            .bind($focus, to: viewStore.$focus)
        }
    }
}


extension Duration {
    fileprivate var minutes: Double {
        get { Double(self.components.seconds / 60)}
        set { self = .seconds(newValue * 60)}
    }
}

struct StandupFomrView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandupFormView(store: Store(initialState: StandupFormFeature.State(standup: .mock), reducer: {
                StandupFormFeature()
            }))
        }
    }
}
