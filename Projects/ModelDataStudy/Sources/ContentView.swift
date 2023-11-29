//
//  ContentView.swift
//  FocusStateStudy
//
//  Created by wooyoung on 2023/10/05.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var stateObjectViewModel = SimpleViewModel()
    @ObservedObject private var observedObjectViewModel = SimpleViewModel()
    @StateObject private var clientViewModel = SimpleViewModel()
    
    var body: some View {
        VStack(content: {
            Button(action: {
                stateObjectViewModel.onButtonTapped()
            }, label: {
                Text("\(stateObjectViewModel.value)")
            })
            
            /*
            observed object를 주입받지 않고 직접 초기화해서 사용하는 경우는 반드시 해당 뷰가 최상단에 위치해 있어야합니다. 어떤 뷰에 의해 호출되지 않아야 합니다.
             
             관찰하고 있는 값(Model data: StateObject, ObservedObject 등이 해당됩니다.)이 변화한 경우 body를 재호출 하면서 body 내부에 있는 뷰가 모두 호출됩니다.
             
             이 때 StateObject는 reinit되지 않고 ObservedObject는 reinit됩니다.
             최상단 뷰에 위치한 ObservedObject는 body에 의해 호출되지 않기때문에 무관합니다.
             */
            Button(action: {
                observedObjectViewModel.onButtonTapped()
            }, label: {
                Text("\(observedObjectViewModel.value)")
            })
            
            InnerStateObjectView()
            
            /*
            이 뷰는 ObservedObject를 주입받지 않고 내부에서 호출하고 있습니다.
             부모뷰가 관찰하는 값이 변하면 값이 초기화됩니다.
             */
            InnerObservedObjectView()
            
            /*
            이 뷰는 ObservedObject를 주입받습니다. 데이터를 부모뷰가 유지하고 있기때문에
             부모뷰가 관찰하는 값이 변해도 값이 유지됩니다. 
             */
            InnerInjectObservedObjectView(viewModel: clientViewModel)
        })
    }
}

#Preview {
    ContentView()
}
