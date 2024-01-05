//
//  ButtonAreaTipView.swift
//  ShortTips
//
//  Created by 노우영 on 1/5/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct ButtonAreaTipView: View {
    var body: some View {
        VStack(spacing: 15) {
            
            /*
             버튼이 tap되는 범위는 Button 바깥에서 지정된 frame이 아니라
             label 내부의 크기에서 정해진다.
             아래 두가지 버튼과 달리 이 버튼이 탭되는 범위는 매우 작다.
             */
            Button {
                debugPrint("Button tapped!")
            } label: {
                Text("Hello, world")
                    .foregroundStyle(.red)
            }
            .frame(width: 250, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red.opacity(0.2))
            )
            
            Text("Frame: 외부 / Backround: 외부")
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            /*
             이 버튼은 인식되는 범위는 크지만
             버튼의 애니메이션 효과가 적용되는 범위가 작다.
             버튼이 눌렸을 때의 시각적인 범위는 label 내부만 해당된다.
             */
            Button {
                debugPrint("Button tapped!")
            } label: {
                Text("Hello, world")
                    .foregroundStyle(.orange)
                    .frame(width: 250, height: 100)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange.opacity(0.2))
            )
            
            Text("Frame: 내부 / Backround: 외부")
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            
            /*
             이 버튼은 보이는 크기만큼 버튼이 인식되고,
             전체에 애니메이션 효과가 적용된다. 
             */
            Button {
                debugPrint("Button tapped!")
            } label: {
                Text("Hello, world")
                    .frame(width: 250, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue.opacity(0.3))
                    )
            }
            
            Text("Frame: 내부 / Backround: 내부")
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ButtonAreaTipView()
}
