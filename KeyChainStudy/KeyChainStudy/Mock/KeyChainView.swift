//
//  KeyChainView.swift
//  KeyChainStudy
//
//  Created by wooyoung on 2023/09/25.
//

import SwiftUI

struct KeyChainView: View {
    
    @StateObject private var viewModel = KeyChainViewModel()        
    var body: some View {
        VStack {
            TextField("Input name", text: viewModel.nameTextBinding)
            
            TextField("Input password", text: viewModel.passwordTextBinding)
            
            Button {
                viewModel.onAddButtonTapped()
            } label: {
                Text("Add")
            }

        }
    }
}

struct KeyChainView_Previews: PreviewProvider {
    static var previews: some View {
        KeyChainView()
    }
}
