//
//  DelegateChildView.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

struct UpdateCountView: View {
    
    @StateObject private var viewModel: UpdateCountViewModel
    
    init(updateCountDelegate: UpdateCountDelegate) {
        let viewModel = UpdateCountViewModel(
            delegate: updateCountDelegate
        )
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            Button {
                viewModel.onUpdateButtonTapped()
            } label: {
                Text("업데이트")
            }

            Text(viewModel.model.countText)
        }

    }
}

#Preview {
    UpdateCountView(updateCountDelegate: NullUpdateCountDelegate())
}
