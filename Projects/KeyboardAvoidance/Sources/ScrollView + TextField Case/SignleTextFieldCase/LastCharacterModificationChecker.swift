//
//  LastCharacterModificationChecker.swift
//  KeyboardAvoidance
//
//  Created by 노우영 on 1/6/24.
//  Copyright © 2024 page. All rights reserved.
//

import Foundation

struct LastCharacterModificationChecker {
    static let shared = LastCharacterModificationChecker()
    
    private init() { }
    
    func checkLastCharacterModification(first: String, second: String) -> Bool {
        let longer: String = first.count > second.count ? first : second
        let shorter: String = first.count < second.count ? first : second
        let startIndex = longer.startIndex
        let endIndex = longer.endIndex
        let index = longer.index(endIndex, offsetBy: -1)
        
        let lastDeletedLonger: String = String(longer[startIndex..<index])
        
        let result = (shorter == lastDeletedLonger)
        return result
    }
}
