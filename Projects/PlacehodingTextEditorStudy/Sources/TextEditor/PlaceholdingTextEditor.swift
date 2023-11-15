//
//  PlaceholdingTextEditor.swift
//  PlaceholdingTextEditor
//
//  Created by wooyoung on 2023/10/24.
//

import SwiftUI

struct PlaceholdingTextEditor<FocusField: Hashable>: View {
    
    let placeholder: String
    let font: Font
    let equals: FocusField
    @Binding var text: String
    @FocusState var focusField: FocusField?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TmpEditor(text: $text, font: font.toUIFont())
                .focused($focusField, equals: equals)
            
            if text.isEmpty && focusField == nil {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .font(font)
            }
        }
        .onTapGesture {
            focusField = equals
        }
    }
}

struct PlaceholdingTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholdingTextEditor(placeholder: "Placeholder", font: .callout, equals: FocusField.text, text: .constant("Text"))
    }
}
