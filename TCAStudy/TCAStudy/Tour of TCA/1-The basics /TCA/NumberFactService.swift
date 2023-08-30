//
//  NumberFactService.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
import ComposableArchitecture

/*
 구 버전에서는 Reducer에 State, Action, Environment를 정의했는데
 정식 출시 되면서 Environment를 없앴다.
 의존성 주입이 필요하면 @Dependency를 사용한다.
 */

/*
 기능을 정의할 때 func가 아닌 주입 받을 수 있는 형태로
 computed property로 작성한다
 */
struct NumberFactCliet {
    var fetch: @Sendable (Int) async throws -> String
}

extension NumberFactCliet: DependencyKey {
    //  테스트가 아닌 running(live) 상황에서의 기능 정의
    static let liveValue: NumberFactCliet = Self { number in
        let url = URL(string: "http://www.numbersapi.com/\(number)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
}

extension DependencyValues {
    var numberFact: NumberFactCliet {
        get { self[NumberFactCliet.self] }
        set { self[NumberFactCliet.self] = newValue }
    }
}
