//
//  ClassView.swift
//  GlobalLoading
//
//  Created by 노우영 on 12/17/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct ClassView: View {
    
    @StateObject private var viewModel = ClassViewModel()
    var body: some View {
        VStack {
            /**
             클래스 타입의 값 변화는 바로 렌더링되지 않는다.
             아마 관찰하는 것은 힙 영역이 아니라 스택 영역의 메모리인 것 같다. 
             */
            Button {
                viewModel.model.value += 1
            } label: {
                Text("current: \(viewModel.model.value)")
            }
            
            Button {
                viewModel.structTypeModel.count += 1
            } label: {
                Text("current: \(viewModel.structTypeModel.count)")
            }
            
        }

    }
}

#Preview {
    ClassView()
}
