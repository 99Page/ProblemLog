//
//  StandupDetailView.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/10/07.
//

import ComposableArchitecture
import SwiftUI

struct StandupDetailFeature: Reducer {
    struct State: Equatable {
        @PresentationState var editStandup: StandupFormFeature.State?
        var standup: Standup
    }
    
    enum Action {
        case cancelEditStandupButtonTapped
        case deleteButtonTapped
        case deleteMeetings(atOffset: IndexSet)
        case editButtonTapped
        case editStandup(PresentationAction<StandupFormFeature.Action>)
        case saveStandupButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelEditStandupButtonTapped:
                state.editStandup = nil
                return .none
            case .deleteButtonTapped:
                return .none
            case .deleteMeetings(atOffset: let atOffset):
                state.standup.meetings.remove(atOffsets: atOffset)
                return .none
            case .editButtonTapped:
                state.editStandup = StandupFormFeature.State(standup: state.standup)
                return .none
            case .editStandup:
                return .none
            case .saveStandupButtonTapped:
                guard let standup = state.editStandup?.standup else
                { return .none}
                
                state.standup = standup
                state.editStandup = nil
                
                return .none
            }
        }
        .ifLet(\.$editStandup, action: /Action.editStandup) {
            StandupFormFeature()
        }
    }
}

struct StandupDetailView: View {
    
    let store: StoreOf<StandupDetailFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section {
                    NavigationLink {
                        
                    } label: {
                        Label("Start meeting", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                    
                    HStack {
                        Label("Length", systemImage: "clock")
                        Spacer()
                        Text(viewStore.standup.duration.formatted(.units()))
                    }

                    HStack {
                        Label("Theme", systemImage: "paintpalette")
                        Spacer()
                        Text(viewStore.standup.theme.name)
                            .padding(4)
                            .foregroundColor(viewStore.standup.theme.accentColor)
                            .background(viewStore.standup.theme.mainColor)
                            .cornerRadius(4)
                    }
                } header: {
                    Text("Standup info")
                }
                
                if !viewStore.standup.meetings.isEmpty {
                    Section {
                        ForEach(viewStore.standup.meetings) { meeting in
                            NavigationLink {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "calendar")
                                    Text(meeting.date, style: .date)
                                    Text(meeting.date, style: .time)
                                }
                            }

                        }
                        .onDelete { index in
                            viewStore.send(.deleteMeetings(atOffset: index))
                        }
                    } header: {
                        Text("Past meeting")
                    }
                }
                
                Section {
                    ForEach(viewStore.standup.attendees) { attendee in
                        Label(attendee.name, systemImage: "person")
                    }
                } header: {
                    Text("Attendee")
                }
                
                Section {
                    Button("Delete") {
                        viewStore.send(.deleteButtonTapped)
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(viewStore.standup.title)
            .toolbar {
                Button("Edit") {
                    viewStore.send(.editButtonTapped)
                }
            }
            // scope는 MVVM에서 내가 프로토콜로 ObservableObject를 뽑아내는 것과 유사하다
            .sheet(store: store.scope(state: \.$editStandup, action: {
                .editStandup($0)
            })) { store in
                NavigationStack {
                    StandupFormView(store: store)
                        .navigationTitle("Edit standup")
                        .toolbar {
                            ToolbarItem {
                                Button("Save") {
                                    viewStore.send(.saveStandupButtonTapped)
                                }
                            }
                            
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    viewStore.send(.cancelEditStandupButtonTapped)
                                }
                            }
                        }
                }
            }
        }
    }
}

struct StandupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandupDetailView(store: Store(initialState: StandupDetailFeature.State(standup: .mock), reducer: {
                StandupDetailFeature()
            }))
        }
    }
}
