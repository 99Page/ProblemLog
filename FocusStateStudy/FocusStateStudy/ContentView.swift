//
//  ContentView.swift
//  FocusStateStudy
//
//  Created by wooyoung on 2023/10/05.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @FocusState private(set) var focus: ContentView.FocusField?
}

struct ContentView: View {
    
    enum FocusField: Hashable {
        case first
        case second
    }
    
    @FocusState private var focus: FocusField?
    @State private var firstText: String = ""
    @State private var secondText: String = ""
    
    var body: some View {
        List {
            
            /**
             iOS 16 버전 이상에서는 onSubmit을 이용해 FocusState 값을 변경 시 키보드가 바운스되는 문제가 있다.
             */
            TextField("First", text: $firstText)
                .keyboardShortcut(.return, modifiers: <#T##EventModifiers#>)
                .keyboardType(.numberPad)
                .focused($focus, equals: .first)
                .onSubmit {
                    focus = .second
                }
                .toolbar {
                    
                    /**
                     버튼을 통해 FocusState를 바꾸면 키보드가 바운스 되지 않는다.
                     */
                  
                    ToolbarItem(placement: .keyboard) {
                        HStack(content: {
                            
                            Spacer()
                            
                            Button(action: {
                                switch focus {
                                case .first:
                                    focus = .second
                                case .second:
                                    focus = .first
                                case nil:
                                    break
                                }
                            }, label: {
                                Text("Focus Change")
                                    .foregroundStyle(.gray)
                            })
                        })
                    }
                }
            
            TextField("Second", text: $secondText)
                .focused($focus, equals: .second)
        }
    }
}

#Preview {
    ContentView()
}
