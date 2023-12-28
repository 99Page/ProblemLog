//
//  ContentView.swift
//  MultiTextEditor
//
//  Created by 노우영 on 12/28/23.
//  Copyright © 2023 page. All rights reserved.
//

import SwiftUI

/**
 iOS 15 이전 버전에는 TextEditor로만 여러 줄을 볼 수 있었다.
 iOS 16 버전 이후부터는 TextField의 값을 조절해서 여러줄을 입력할 수 있다.

 
 [이 영상](https://developer.apple.com/videos/play/wwdc2022/10052/)의 17:10에서 확인 가능하다.
 */
struct ContentView: View {
    @State private var text1: String = ""
    @State private var text2: String = ""
    
    var body: some View {
        VStack {
            TextField("Input text", text: $text1, axis: .vertical)
                .font(.system(size: 20))
                .background(
                    Color.blue.opacity(0.2)
                )
            
            TextField("Input text", text: $text2, axis: .vertical)
                .font(.system(size: 20))
                .background(
                    Color.red.opacity(0.2)
                )
        }
    }
}

#Preview {
    ContentView()
}
