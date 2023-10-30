//
//  ViewModelParentView.swift
//  Viewmodel-Delegate-Study
//
//  Created by wooyoung on 2023/10/30.
//

import SwiftUI

struct CountParentView: View {
    @StateObject private var viewModel = CountParentViewModel()
    var body: some View {
        Button {
            viewModel.onPresentSheetButtonTapped()
        } label: {
            Text("Present sheet, currentValue: \(viewModel.childModel.value)")
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            CountChildView(viewModel: viewModel)
        }
    }
}

#Preview {
    CountParentView()
}
