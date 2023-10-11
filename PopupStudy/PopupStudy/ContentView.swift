//
//  ContentView.swift
//  PopupStudy
//
//  Created by 노우영 on 2023/10/09.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alert: AlertConfig = .init()
    
    var body: some View {
        Button("Show Alert") {
            alert.present()
        }
        .alert(alertConfig: $alert) {
            RoundedRectangle(cornerRadius: 15)
                .fill(.red.gradient)
                .frame(width: 150, height: 150)
                .onTapGesture {
                    alert.dismiss()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SceneDelegate())
    }
}
