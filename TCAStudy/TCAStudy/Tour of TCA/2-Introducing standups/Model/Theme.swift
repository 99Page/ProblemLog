//
//  Theme.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Equatable,Hashable,
            Identifiable, Codable {
    case blue
    case navy
    case orange
    case yellow
    case green


    var id: Self { self }

    var accentColor: Color {
        switch self {
        case .orange, .yellow, .green:
          return .black
        case.navy, .blue:
          return .white
        }
    }

    var mainColor: Color { Color(self.rawValue) }

    var name: String { self.rawValue.capitalized }
}
