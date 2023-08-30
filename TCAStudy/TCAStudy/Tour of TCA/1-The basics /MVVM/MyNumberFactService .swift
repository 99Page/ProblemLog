//
//  MyNumberFactService .swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation

protocol MyNumberFactServiceProtocol {
    func fetch(_ count: Int) async throws -> String
}

struct MyNumberFactService: MyNumberFactServiceProtocol {
    func fetch(_ number: Int) async throws -> String {
        try await Task.sleep(for: .seconds(1))
        let url = URL(string: "http://www.numbersapi.com/\(number)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
}

struct MyNumberFactStubService: MyNumberFactServiceProtocol {
    func fetch(_ count: Int) async throws -> String {
        return "count: \(count)"
    }
}
