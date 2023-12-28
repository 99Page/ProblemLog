//
//  SemaphoreView.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/26/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct SemaphoreView: View {
    @StateObject private var viewModel = SemaphoreViewModel()
    var body: some View {
        VStack(content: {
            Button {
                viewModel.increase()
            } label: {
                Text("increase")
            }
            
            if viewModel.count == 0 {
                Text("??")
            }
        })
    }
}

#Preview {
    SemaphoreView()
}
