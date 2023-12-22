//
//  TodoViewModel.swift
//  IdentifiedArrayStudy
//
//  Created by wooyoung on 12/22/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation
import IdentifiedCollections

final class TodoViewModel: ObservableObject {
    @Published var identifiedTodos: IdentifiedArrayOf<TodoModel> = .init()
    @Published var todos: [TodoModel] = .init()
    
    func removeIdentifiedTodo(_ todo: TodoModel) {
        identifiedTodos.remove(id: todo.id)
    }
    
    func removeLastIdentifiedTodo() {
        identifiedTodos.removeLast()
    }
}
