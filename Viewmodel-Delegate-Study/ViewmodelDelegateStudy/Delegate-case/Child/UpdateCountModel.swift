//
//  UpdateCountModel.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import Foundation

struct UpdateCountModel {
    var count: Int = 0 
    
    var countText: String {
        return "업데이트 횟수: \(count)"
    }
}
