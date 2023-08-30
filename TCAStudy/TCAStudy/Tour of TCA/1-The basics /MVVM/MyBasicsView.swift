//
//  MyBasicsView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import SwiftUI

struct MyBasicsView: View {
    
    @StateObject private var viewmodel = MyCounterViewmodel(numberFactService: MyNumberFactService())
    
    var body: some View {
        Form {
            Section {
                Text("\(viewmodel.myCounterModel.count)")
                
                Button("Decrement") {
                    viewmodel.onDecementedButtonTapped()
                }
                
                Button("Increment") {
                    viewmodel.onIncrementButtonTapped()
                }
            }
            
            Section {
                HStack {
                    Button("Get fact") {
                        Task { await viewmodel.onGetFactButtonTapped() }
                    }
                    
                    if viewmodel.myCounterModel.isLoadingFact {
                        Spacer()
                        ProgressView()
                    }
                }

                if let fact = viewmodel.myCounterModel.fact {
                    Text(fact)
                }
            }

            Section {
                Button(viewmodel.myCounterModel.timerText) {
                    Task { await viewmodel.onToggleTimerButtonTapped() } 
                }
            }
        }
    }
}

struct MyBasicsView_Previews: PreviewProvider {
    static var previews: some View {
        MyBasicsView()
    }
}
