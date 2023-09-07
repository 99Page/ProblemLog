//
//  Example.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import SwiftUI
import CombineMoya
import Moya
import Combine
import Alamofire

final class MoyaViewmodel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    private let jsonPlaceholderProvider: MoyaProvider<JsonPlaceHolder>
    
    init(jsonPlaceholderProvider: MoyaProvider<JsonPlaceHolder>) {
        self.jsonPlaceholderProvider = jsonPlaceholderProvider
    }
    
    func get() {
        jsonPlaceholderProvider.requestPublisher(.getPost)
            .map(Welcome.self)
            .sink(receiveCompletion: { error in
                debugPrint("error: \(error)")
            }, receiveValue: { welcome in
                debugPrint("receiveValue: \(welcome)")
            })
            .store(in: &cancellable)
    }
    
    func post() {
        jsonPlaceholderProvider.requestPublisher(.post(.stub()))
            .map(Title.self)
            .sink(receiveCompletion: { error in
                debugPrint("error: \(error)")
            }, receiveValue: { title in
                debugPrint("receivedValue: \(title)")
            })
            .store(in: &cancellable)
    }
    
    func testAPI() async {
        let url = "https://172.30.1.12/api/access/authentication/token/application"
                
        let response = await AF.request(url, method: .post)
            .serializingDecodable(String.self)
            .response
        
        switch response.result {
        case .success(let success):
            debugPrint(success)
        case .failure(let err):
            debugPrint(err)
        }
    }
}
