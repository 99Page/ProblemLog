//
//  Title.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import Foundation

struct Title: Codable {
    let id: Int
    let title: String
    
    static func stub() -> Title {
        Title(id: 1, title: "title")
    }
}
