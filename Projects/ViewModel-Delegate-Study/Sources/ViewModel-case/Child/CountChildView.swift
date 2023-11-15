//
//  ViewModelChildView.swift
//  Viewmodel-Delegate-Study
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

struct CountChildView<ViewModel: CountChildViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        
        VStack {
            Button {
                viewModel.onButtonTapped()
            } label: {
                Text("Value: \(viewModel.childModel.value)")
            }
        }
    }
}

#Preview {
    CountChildView(viewModel: NullViewModelChildViewModel())
}
