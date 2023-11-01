//
//  ContentView.swift
//  Tst
//
//  Created by wooyoung on 2023/10/31.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: TstDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(TstDocument()))
}
