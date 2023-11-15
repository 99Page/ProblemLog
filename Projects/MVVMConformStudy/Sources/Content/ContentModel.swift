//
//  ContentModel.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import Foundation

struct ContentModel: ComponentModel {
    var value: Int
    
    mutating func updateValue(_ component: ComponentModel) {
        value = component.value
    }
}
