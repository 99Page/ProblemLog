//
//  ContentView.swift
//  Xcode15Study
//
//  Created by wooyoung on 2023/09/25.
//

import SwiftUI

/**
 Assistance의 Documentation preview를 이용하면 내 문서를 작성하면서 빠르게 확인할 수 있다.
 
 한칸 띄어쓰면 overview에 작성된다.
 */
struct ContentView: View {
    
    /// 문서를 작서앟고 있는 위치에 따라서
    /// 문서가 자동으로 변경된다.
    var body: some View {
        VStack {
            // asset에 추가하기만 하면 내가 color extension으로 만들 필요없이 바로 이용 가능
            Color.mycolor
            Color.lowerCamelCase
        }
        .padding()
        // 어떤 값을 패러미터로 주입할 지 오른쪽 방향키로 선택 가능
        .frame(width: 100)
    }
}

#Preview {
    ContentView()
}
