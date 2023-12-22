//
//  TodoModel.swift
//  IdentifiedArrayStudy
//
//  Created by wooyoung on 12/22/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

struct TodoModel {
    let title: String
}

extension TodoModel: Identifiable {
    var id: String {
        UUID().uuidString
    }
}
