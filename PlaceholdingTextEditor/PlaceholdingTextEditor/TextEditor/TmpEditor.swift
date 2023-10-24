//
//  TmpEditor.swift
//  PlaceholdingTextEditor
//
//  Created by wooyoung on 2023/10/24.
//

import SwiftUI

struct TmpEditor: UIViewRepresentable {
    
    @Binding var text: String
    let font: UIFont
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = font
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
