//
//  BadgeBackground.swift
//  DrawingStudy
//
//  Created by wooyoung on 2023/10/18.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        GeometryReader(content: { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width - 300, geometry.size.height)
                let height = width
                
                path.move(
                    to: CGPoint(
                        x: width * 0.95,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x,
                            y: height * segment.line.y
                        )
                    )
                    
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x,
                            y: height * segment.curve.y),
                        control: CGPoint(
                            x: width * segment.control.x,
                            y: width * segment.control.y)
                    )
                }
            }
            .fill(.black)
            
        })
    }
}

#Preview {
    BadgeBackground()
}
