//
//  View + detectLastCharacterModification.swift
//  KeyboardAvoidance
//
//  Created by 노우영 on 1/6/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct DetectLastCharacterModification: ViewModifier {
    
    @Binding var text: String
    let lastViewId: any Hashable
    
    func body(content: Content) -> some View {
        ScrollViewReader { proxy in
            content
                .onChange(of: text) { oldValue, newValue in
                    let checker = LastCharacterModificationChecker.shared
                    guard checker.checkLastCharacterModification(first: oldValue, second: newValue) else { return }
                    proxy.scrollTo(lastViewId)
                }
        }
    }
}
