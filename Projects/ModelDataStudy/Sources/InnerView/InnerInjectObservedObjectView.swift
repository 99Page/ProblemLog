//
//  InnerInjectObservedObjectView.swift
//  ModelDataStudy
//
//  Created by wooyoung on 2023/11/29.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct InnerInjectObservedObjectView: View {
    @ObservedObject var viewModel = SimpleViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.onButtonTapped()
        }, label: {
            Text("\(viewModel.value)")
        })
    }
}

#Preview {
    InnerInjectObservedObjectView()
}
