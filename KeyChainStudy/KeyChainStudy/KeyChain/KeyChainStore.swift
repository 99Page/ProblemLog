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
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword, // 저장될 정보는 인터넷 패스워드고 암호화가 필요하다는 것을 알려준다.
            kSecAttrAccount as String: account, // Account와 Server를 이용해서 다른 인터넷 비밀번호와 구분할 수 있다.
            kSecAttrServer as String: Self.server,
            kSecValueData as String: password // 저장될 패스워드는 인코딩된 Data 타입이여야한다.
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
    }
    
    func read() throws -> Credentials {
        
        // read를 하기 위한 쿼리 작성. add에서 사용한 것과 동일해야한다.
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server,
            kSecMatchLimit as String: kSecMatchLimitOne, // Server를 이용해서 저장한 것중에 하나만 반환한다. 처음 저장된 것을 반환하는 것 같음.
            kSecReturnAttributes as String: true, // Account를 반환
            kSecReturnData as String: true // 비밀번호 반환
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
        
        return Credentials(username: account, password: password)
    }
    
    /*
     같은 Server, 같은 Account로 저장된 정보가 이미 있는 경우 SecItemAdd를 호출하면 에러가 발생한다.
     이런 경우에 Update 혹은 Delete가 필요하다
     */
    func readPasswordOf(_ name: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server,
            kSecAttrAccount as String: name,
            kSecReturnData as String: true // 비밀번호 반환
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
   
        guard let existringItem = item as? Data, // 쿼리의 return data가 한개인 경우 딕셔너리가 아니라 Data로 들어온다.
              let password = String(data: existringItem, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    // 업데이트는 암시적으로 Read를 수행한다. 
    func update(_ credentials: Credentials) throws {
        
        /*
         필요한 정보를 찾기 위한 기본적인 쿼리다.
         */
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Self.server,
            kSecAttrAccount as String: credentials.username
        ]
        
        let password = credentials.password.data(using: String.Encoding.utf8)!
        
        /*
         쿼리에 해당하는 범위에서
         바꾸고 싶은 정보를 설정한다.
         */
        let attributes: [String: Any] = [
            kSecValueData as String: password
        ]
        
        // query 결과 반환된 곳의 정보를 attribute로 변환한다. 
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
