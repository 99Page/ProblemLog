//
//  FruitViewModel.swift
//  BindingConventionStudy
//
//  Created by wooyoung on 2023/11/01.
//

import SwiftUI


final class SimpleTypingViewModel: ObservableObject {
    @Published var model = SimpleTypeModel()
    @Published private(set) var description: String = ""
    @Published private(set) var originValue: Int = 0
}

extension SimpleTypingViewModel: ChildViewModel {
    var value: Int {
        get {
            originValue
        }
        set {
            originValue = newValue
        }
    }
}

extension SimpleTypingViewModel {
    var descriptionBinding: Binding<String> {
        .init {
            self.description
        } set: {
            debugPrint("newValue: \($0)")
            self.description = $0
        }
    }
}
