//
//  3-FocusState.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/23.
//

import ComposableArchitecture
import SwiftUI

struct FocusDemo: Reducer {
    struct State: Equatable {
        @BindingState var focusedField: Field?
        @BindingState var password: String = ""
        @BindingState var username: String = ""
        
        
        enum Field: String, Hashable {
            case username, password
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case signInButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .signInButtonTapped:
                if state.username.isEmpty {
                    state.focusedField = .username
                } else if state.password.isEmpty {
                    state.focusedField = .password
                }
                
                return .none
            }
        }
    }
}

struct FocusDemoView: View {
    
    let store: StoreOf<FocusDemo>
    @FocusState var focusedField: FocusDemo.State.Field?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                TextField("Username", text: viewStore.$username)
                    .focused($focusedField, equals: .username)
                
                SecureField("Password", text: viewStore.$password)
                    .focused($focusedField, equals: .password)
                
                Button("Sign In") {
                    viewStore.send(.signInButtonTapped)
                }
                .buttonStyle(.borderedProminent)
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}

