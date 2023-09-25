//
//  KeyChainStore.swift
//  KeyChainStudy
//
//  Created by wooyoung on 2023/09/22.
//

import Foundation

/*
 키체인을 다루는 직접적인 메소드는 4가지다.
 - SecItemAdd
 - SecItemDelete
 - SecItemCopyMatching
 - SecItemUpdate
 */
struct KeyChainStore {
    
    static let shared = KeyChainStore()
    
    static let server = "www.example.com"
    
    // 앱의 메모리에 저장할 정보. 간단히 유저 이름과 비밀번호만 저장한다.
    struct Credentials {
        var username: String
        var password: String
    }

    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    /*
     저장된 정보를 찾기 위해서는 사용된 attribute를 정확히 알아야한다.
     이곳에서는 Account, Server가 해당되는데
     Server는 고정된 값, Account는 변하는 값이다.
     Account는 여러개가 있을 수 있으니 이와 매칭시켜서 암호를 저장하면 된다.
     만약 식별 값이 더 필요하다면 kSecAttrLabel을 추가로 사용하면 된다. 
     */
    func add(_ credential: Credentials) throws {
        let account = credential.username
        let password = credential.password.data(using: String.Encoding.utf8)!
        
        // 저장할 데이터를 위한 쿼리.
        var query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword, // 저장될 정보는 인터넷 패스워드고 암호화가 필요하다는 것을 알려준다.
            kSecAttrAccount as String: account, // Account와 Server를 이용해서 다른 인터넷 비밀번호와 구분할 수 있다.
            kSecAttrServer as String: Self.server,
            kSecValueData as String: password // 저장될 패스워드는 인코딩된 Data 타입이여야한다.
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
    }
    
    func read(_ credentials: Credentials) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existringItem = item as? [String: Any],
        let passwordData = existringItem[kSecValueData as String] as? Data,
        let password = String(data: passwordData, encoding: String.Encoding.utf8),
        let account = existringItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        let credentials = Credentials(username: account, password: password)
    }
    
    func update(_ credentials: Credentials) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server
        ]
        
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        
        let attributes: [String: Any] = [
            kSecAttrAccount as String: account,
            kSecValueData as String: password
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
    }
    
    
    func delete(_ credentials: Credentials) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server
        ]
        
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
