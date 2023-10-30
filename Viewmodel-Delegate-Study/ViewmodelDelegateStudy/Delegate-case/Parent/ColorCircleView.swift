//
//  ColorCircleView.swift
//  ViewmodelDelegateStudy
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

struct ColorCircleView: View {
    
    @StateObject private var viewModel = ColorCircleViewModel()
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(viewModel.model.color)
            
            Button {
                viewModel.onPresentUpdateCountButtonTapped()
            } label: {
                Text("Show update count view")
            }
            .sheet(isPresented: $viewModel.model.isUpdateCountViewPresented) {
                UpdateCountView(updateCountDelegate: viewModel)
            }

        }

    }
}

#Preview {
    ColorCircleView()
}
