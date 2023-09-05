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
}
