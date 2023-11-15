//
//  ContentView.swift
//  PlaceholdingTextEditor
//
//  Created by wooyoung on 2023/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
            
            PlaceholdingTextEditor(placeholder: "Placeholder",
                                   font: .caption,
                                   equals: FocusField.text,
                                   text: $text)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
