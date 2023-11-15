//
//  ComponentView.swift
//  MVVMConformStudy
//
//  Created by wooyoung on 2023/11/01.
//

import SwiftUI

struct ComponentView<ViewModel: ComponentViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Text("value: \(viewModel.componentModel.value)")
            
            Button {
                viewModel.onButtonTapped()
            } label: {
                Text("up")
            }

        }
    }
}
