//
//  PathCurvePractiveView.swift
//  DrawingStudy
//
//  Created by wooyoung on 2023/10/18.
//

import SwiftUI

struct PathCurvePractiveView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            Path({ path in
                let width = geometry.frame(in: .global).width * 0.5
                
                let start = CGPoint(x: 0, y: 0)
                path.move(to: start)
                
                
                // 커브를 만드는 방법
                // 1. x축은 start 지점
                // 2. y축은 end 지점
                // 혹은 그 반대도 가능 
                
                // x축이 start 지점이면 아래로 볼록하고
                // y축이 start 지점이면 위로 볼록하다
                let target = CGPoint(x: width, y: width * 2)
                path.addQuadCurve(
                    to: target,
                    control: CGPoint(x: 0, y: target.y)
                )
                
                let nextTarget = CGPoint(x: target.x * 2, y: target.y * 2)
                path.addQuadCurve(
                    to: nextTarget,
                    control: CGPoint(x: nextTarget.x, y: target.y)
                )
            })
            .stroke(lineWidth: 5)
        })
    }
}

#Preview {
    PathCurvePractiveView()
}
