//
//  UnissuedFullScreenButtonView.swift
//  TransactionStudy
//
//  Created by wooyoung on 2023/10/18.
//

import SwiftUI

struct UnissuedFullScreenButtonView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    
    var body: some View {
        Button(action: {
            viewModel.isFullScreenPresented = true
        }, label: {
            Text("Unissued")
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

struct UnissuedFullScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UnissuedFullScreenButtonView(viewModel: ContentViewModel())
    }
}
