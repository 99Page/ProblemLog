//
//  ClassViewModel.swift
//  GlobalLoading
//
//  Created by 노우영 on 12/17/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class ClassViewModel: ObservableObject {
    @Published var model = ClassModel()
    @Published var structTypeModel = StructModel()
    
    init() {
        
    }
}
