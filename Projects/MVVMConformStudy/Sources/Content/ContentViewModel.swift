//
//  ContentViewModel.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import Foundation

final class ContentViewModel {
    @Published var model = ContentModel(value: 0)
}

extension ContentViewModel: ComponentViewModel {
    var componentModel: ContentModel {
        get { model }
        set { model.updateValue(newValue) }
    }
}
