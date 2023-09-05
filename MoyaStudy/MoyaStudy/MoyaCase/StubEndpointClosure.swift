//
//  StubEndpointClosure.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import Foundation
import Moya

//  Test 시에 사용하기 위한 스텁을 정의한 클로저
let stubEndpointClosure = { (target: JsonPlaceHolder) -> Endpoint in
    return Endpoint(url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
}

//  networkResponse가 4xx~5xx여도 처리될 때는 error에서 처리되는게 아니라 receivedValue에서 처리된다.
//  실제로 에러가 나오면 error에서 처리되는거를 보아서는 좀 부적절한거 같다.
//  Mock 테스트할 때도 좋지는 않다.
let failEndpointClosure = { (target: JsonPlaceHolder) -> Endpoint in
    return Endpoint(url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(500, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
}

