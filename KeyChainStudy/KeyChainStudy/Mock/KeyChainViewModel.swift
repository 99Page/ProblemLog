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
        
        // main thread에서 실행하면 warning창이 표시된다
        DispatchQueue.global(qos: .background).async {
            do {
                try self.store.add(.init(username: self.model.name, password: self.model.password))
                debugPrint("add success")
            } catch {
                debugPrint("add error: \(error.localizedDescription)")
            }
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
    
    func onChangePasswordButtonTapped() {
        do {
            try store.updatePasswordOf(.init(username: model.name, password: model.password))
            debugPrint("update success")
        } catch {
            debugPrint("update error: \(error.localizedDescription)")
        }
    }
    
    func onDeleteAnyOneButtonTapped() {
        // main thread에서 실행하면 warning창이 표시된다
        DispatchQueue.global(qos: .background).async {
            do {
                try self.store.delete()
                debugPrint("Delete success")
            } catch {
                debugPrint("delete error: \(error.localizedDescription)")
            }
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
