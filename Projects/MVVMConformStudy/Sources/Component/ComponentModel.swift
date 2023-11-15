//
//  ComponentModel.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import Foundation

protocol ComponentModel {
    var value: Int { get set } 
    mutating func updateValue(_ component: ComponentModel)
}
