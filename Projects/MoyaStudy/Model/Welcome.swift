//
//  Welcome.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import Foundation

struct Welcome: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    static func stub() -> Welcome {
        Welcome(userID: 1, id: 1, title: "title", body: "body")
    }
}
