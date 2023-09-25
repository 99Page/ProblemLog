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
            
            Button {
                viewModel.onReadOneButtonTapped()
            } label: {
                Text("Read any one")
            }

            Button {
                viewModel.onReadThisButotnTapped()
            } label: {
                Text("Read user password")
            }

        }
    }
}

struct KeyChainView_Previews: PreviewProvider {
    static var previews: some View {
        KeyChainView()
    }
}
