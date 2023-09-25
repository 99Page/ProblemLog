//
//  KeyChainViewModel.swift
//  KeyChainStudy
//
//  Created by wooyoung on 2023/09/25.
//

import Foundation
import SwiftUI

final class KeyChainViewModel: ObservableObject {
    @Published private(set) var model = KeyChainModel(name: "", password: "")
    
    private let store = KeyChainStore.shared
    
    func onAddButtonTapped() {
        do {
            try store.add(.init(username: model.name, password: model.password))
            debugPrint("add success")
        } catch {
            debugPrint("add error: \(error.localizedDescription)")
        }
    }
    
    func onReadOneButtonTapped() {
        do {
            let result = try store.read()
            debugPrint("read success: \(result)")
        } catch {
            debugPrint("read error: \(error.localizedDescription)")
        }
    }
    
    func onReadThisButotnTapped() {
        do {
            let result = try store.readPasswordOf(model.name)
            debugPrint("read this success: \(result)")
        } catch {
            debugPrint("read this error: \(error.localizedDescription)")
        }
    }
    
    var nameTextBinding: Binding<String> {
        .init {
            self.model.name
        } set: { newValue in
            self.model.name = newValue
        }

    }
    
    var passwordTextBinding: Binding<String> {
        .init {
            self.model.password
        } set: { newValue in
            self.model.password = newValue
        }

    }
}
