//
//  LikeViewmodel.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import Foundation
import SwiftUI

final class LikeViewmodel: ObservableObject {
    
    let heartColor: Color
    var likeButtonTapped: () -> ()
    
    init(heartColor: Color,
         likeButtonTapped: @escaping () -> ()) {
        self.heartColor = heartColor
        self.likeButtonTapped = likeButtonTapped
    }
}
