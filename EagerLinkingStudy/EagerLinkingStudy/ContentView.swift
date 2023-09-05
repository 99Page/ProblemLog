//
//  ContentView.swift
//  EagerLinkingStudy
//
//  Created by wooyoung on 2023/09/04.
//

import SwiftUI
import DynamicLibrary
import DynanicLibrary3
import DynamicLibrary4

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(DynamicLibrary.greeting)
            
            Text(DynanicLibrary3.value)
            
            Text(DynamicLibrary4.value)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
