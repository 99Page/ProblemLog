//
//  UIKitTextField.swift
//  FocusStateStudy
//
//  Created by wooyoung on 2023/10/05.
//

import Foundation
import SwiftUI

struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    @Binding var focus: ContentView.FocusField?
    
    func makeUIView(context: UIViewRepresentableContext<UIKitTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<UIKitTextField>) {
        uiView.placeholder = placeholder
        uiView.text = text
        
        if focus == .second {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextField
        
        init(_ parent: UIKitTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
