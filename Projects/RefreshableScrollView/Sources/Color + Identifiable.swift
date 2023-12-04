//
//  Color + Identifiable.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/4/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

extension Color: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}
