//
//  ColorCircleViewModel.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

final class ColorCircleViewModel: ObservableObject {
    @Published var model = ColorCircleModel()
    
    func onPresentUpdateCountButtonTapped() {
        model.isUpdateCountViewPresented = true
    }
}

/**
 하위 뷰에 전달할 동작이니 상위 뷰에서는 접근하지 않는 것이 좋지만 private으로 처리할 수 없습니다.
 네이밍을 통해서 상위 뷰에서 사용하지 않는 방법이 필요합니다.
 각 뷰에서 동작할 함수는 on~
 delegate로 동작할 함수는 did~ 형식으로 작성합니다.
 */
extension ColorCircleViewModel: UpdateCountDelegate {
    internal func didTapUpdateButton() {
        let colors: [Color] = [.blue, .green, .yellow, .orange, .purple, .pink]
        model.color = colors.randomElement() ?? .brown
    }
}
