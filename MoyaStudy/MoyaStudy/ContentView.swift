//
//  ContentView.swift
//  MoyaStudy
//
//  Created by wooyoung on 2023/09/05.
//

import SwiftUI
import Moya

struct ContentView: View {
    
    @StateObject private var viewmodel = MoyaViewmodel(jsonPlaceholderProvider: MoyaProvider())
    
    var body: some View {
        
        VStack {
            Button {
                viewmodel.get()
            } label: {
                Text("API Call with moya")
            }
            .buttonStyle(.bordered)
            
            Button {
                viewmodel.post()
            } label: {
                Text("Post title with Moya")
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
