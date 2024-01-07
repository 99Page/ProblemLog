//
//  View + detectLastCharacterModification.swift
//  KeyboardAvoidance
//
//  Created by 노우영 on 1/6/24.
//  Copyright © 2024 page. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func detectlastCharacterModification(text: Binding<String>, lastViewid: any Hashable) -> some View {
        self
            .modifier(DetectLastCharacterModification(text: text, lastViewId: lastViewid))
    }
}
