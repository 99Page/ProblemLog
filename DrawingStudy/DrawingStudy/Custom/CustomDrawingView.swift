//
//  CustomDrawingView.swift
//  DrawingStudy
//
//  Created by wooyoung on 2023/10/18.
//

import SwiftUI

struct CustomDrawingView: View {
    
    @State var startPoint = CGPoint(x: 0, y: 0)
    @State var targetPoints: [CGPoint] = []
    
    var body: some View {
        ZStack {
            Path { path in
                targetPoints.forEach {
                    path.move(to: startPoint)
                    
                    let middleTarget = CGPoint(
                        x: (startPoint.x + $0.x) * 0.5,
                        y: (startPoint.y + $0.y) * 0.5
                    )
                    
                    let target = CGPoint(
                        x: $0.x,
                        y: $0.y
                    )
                    
                    path.addQuadCurve(
                        to: middleTarget,
                        control: CGPoint(
                            x: middleTarget.x,
                            y: startPoint.y
                        )
                    )
                    
                    path.addQuadCurve(
                        to: target,
                        control: CGPoint(
                            x: middleTarget.x,
                            y: target.y
                        )
                    )
                }
            }
            .stroke(.blue, lineWidth: 4)
            .zIndex(1)
            
            HStack(alignment: .top, content: {
                Circle()
                    .background {
                        GeometryReader(content: { geometry in
                            Color.clear
                                .onAppear {
                                    let x = geometry.frame(in: .global).maxX
                                    let y = geometry.frame(in: .global).minY
                                    startPoint = CGPoint(x: x, y: y)
                                }
                        })
                    }
                
                Circle()
                    .foregroundStyle(.clear)
                
                VStack(content: {
                    Circle()
                        .background {
                            GeometryReader(content: { geometry in
                                Color.clear
                                    .onAppear {
                                        targetPoints.append(geometry.frame(in: .global).origin)
                                    }
                            })
                        }
                    Circle()
                        .background {
                            GeometryReader(content: { geometry in
                                Color.clear
                                    .onAppear {
                                        targetPoints.append(geometry.frame(in: .global).origin)
                                    }
                            })
                        }
                    Circle()
                        .background {
                            GeometryReader(content: { geometry in
                                Color.clear
                                    .onAppear {
                                        targetPoints.append(geometry.frame(in: .global).origin)
                                    }
                            })
                        }
                })
            })
        }
    }
}

#Preview {
    CustomDrawingView()
}
