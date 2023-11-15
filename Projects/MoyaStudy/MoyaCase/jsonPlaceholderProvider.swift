//
//  SimpleAPIProvider.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import Foundation
import CombineMoya
import Moya

enum JsonPlaceHolder: TargetType {
    
    case getPost
    case post(Title)
    
    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String {
        switch self {
        case .getPost:
            return "/posts/1"
        case .post:
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPost:
            return .get
        case .post:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPost:
            return .requestPlain
        case let .post(title):
            return .requestJSONEncodable(title)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getPost:
            if let data = try? JSONEncoder().encode(Welcome.stub()) {
                return data
            } else {
                return Data()
            }
        case .post(_):
            if let data = try? JSONEncoder().encode(Title.stub()) {
                return data
            } else {
                return Data()
            }
        }
    }
    
    var headers: [String : String]? { nil }
}
