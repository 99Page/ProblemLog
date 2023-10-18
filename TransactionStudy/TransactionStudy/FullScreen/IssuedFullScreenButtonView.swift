//
//  FullScreenView.swift
//  TransactionStudy
//
//  Created by wooyoung on 2023/10/17.
//

import SwiftUI

struct IssuedFullScreenButtonView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Button(action: {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                viewModel.isFullScreenPresented = true
            }
        }, label: {
            Text("Issued")
        })
        .fullScreenCover(isPresented: $viewModel.isFullScreenPresented, content: {
            Button(action: {
                viewModel.isFullScreenPresented = false
            }, label: {
                Text("dismiss full screen covoer")
            })
        })
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        IssuedFullScreenButtonView(viewModel: ContentViewModel())
    }
}
