//
//  LoadingCallerView.swift
//  GlobalLoading
//
//  Created by 노우영 on 12/17/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

struct LoadingCallerView: View {
    
    @State private var model: LoadingCallerModel
    
    init(model: LoadingCallerModel) {
        self._model = State(initialValue: model)
    }
    
    var body: some View {
        VStack {
            Text("\(model.text)")
        }
        .onAppear {
            debugPrint("\(model.text)")
            
            Task {
                do {
                    GlobalLoader.shared.add()
                    try await Task.sleep(for: .seconds(2))
                    GlobalLoader.shared.down()
                } catch {
                    GlobalLoader.shared.down()
                }
            }
            
            debugPrint("isNavigated: \(model.isNavigated)")
            debugPrint("shouldNavigate: \(model.shouldNavigateAfterLoading)")
            guard model.shouldNavigate else { return }
            model.isNavigated = true
            
            // 두가지 모두 DispatchQueue.main에서 동작 시켜야 화면 이동 및 로딩 뷰가 정상적으로 나온다.
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Navigator.shared.navigate(to: .loadingCaller(.init(text: "Second view", shouldNavigateAfterLoading: false)))
            }
        }
    }
}

#Preview {
    LoadingCallerView(model: .init(text: "Text",
                                   shouldNavigateAfterLoading: false))
}
