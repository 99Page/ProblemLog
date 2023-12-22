//
//  Navigator.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/15/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

@MainActor
final class Navigator: ObservableObject {
    @Published var navigatinoPath: [CustomPath] = []
    
    static let shared = Navigator()
    
    private init() { }
    
    func navigate(to path: CustomPath) {
        navigatinoPath.append(path)
    }
}
