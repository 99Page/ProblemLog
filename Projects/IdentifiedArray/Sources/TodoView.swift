//
//  TodoView.swift
//  IdentifiedArrayStudy
//
//  Created by wooyoung on 12/22/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    var body: some View {
        List {
            ForEach(viewModel.identifiedTodos.indices, id: \.self) { i in
                Text("..")
            }
        }
    }
}

#Preview {
    TodoView()
}
