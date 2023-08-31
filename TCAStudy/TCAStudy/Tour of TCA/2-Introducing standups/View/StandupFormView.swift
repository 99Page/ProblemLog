//
//  StandupFormView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import SwiftUI
import ComposableArchitecture

struct StandupFormView: View {
    
    let store: StoreOf<StandupFormFeature>
    
    //  focus를 위해서는 View에 FocusState 선언, State에도 동일하게 선언 후 bind 필요
    //  bind는 아래에 작성됨
    @FocusState var focus: StandupFormFeature.State.Field?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section {
                    TextField("Title", text: viewStore.$standup.title)
                    
                    HStack {
                        Slider(value: viewStore.$standup.duration.minutes)
                        Spacer()
                        Text("5 min")
                    }
                    
                    ThemePicker(selection: viewStore.$standup.theme)
                } header: {
                    Text("STANDUP INFO")
                }
                
                Section {
                    ForEach(viewStore.$standup.attendees) { $attendee in
                        TextField("Name", text: $attendee.name)
                            .focused($focus, equals: .attendee(attendee.id))
                    }
                    .onDelete { indices in
                        store.send(.deleteAttendee(atOffsets: indices))
                    }
                    
                    Button {
                        viewStore.send(.addAttendeeButtonTapped)
                    } label: {
                        Text("Add attendee")
                    }

                } header: {
                    Text("ATEENDEES")
                }

            }
            //  양쪽의 값을 동일하게 유지해줌
            .bind(viewStore.$field, to: $focus)
        }
    }
}

struct StandupFormView_Previews: PreviewProvider {
    static var previews: some View {
        StandupFormView(store: Store(initialState: StandupFormFeature.State(standup: .mock()),
                                     reducer: {
            StandupFormFeature()
        }))
    }
}
