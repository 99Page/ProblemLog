//
//  ContentView.swift
//  RoundendRectangleStudy
//
//  Created by wooyoung on 2023/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(content: {
            
            /*
             RoundendRectangle을 정적인 값이 아닌 도형의 크기에 맞춰서 동적으로 설정하는 방법을 찾아보려했지만 그런 방법은 없습니다.
             만약 동적을 해야하는 경우라면 GeometryReader 사용이 필수적입니다.
             */
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 40)
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .frame(width: 200, height: 200)
            
            /*
             cornerRadius 20은 CGSize(widht: 20, height: 20)과 동일합니다. 
             */
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200)
            
            /*
             도형의 크기와 cornerRadius 값이 동일하면 원이 됩니다.
             */
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 20, height: 20)
        })
    }
}

#Preview {
    ContentView()
}
