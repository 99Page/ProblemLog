//
//  ViewPoint.swift
//  DrawingStudy
//
//  Created by wooyoung on 2023/10/19.
//

import SwiftUI

extension View {
    func getPoint(closure: @escaping (CGPoint) -> ()) -> some View {
        self
            .background {
                GeometryReader(content: { geometry in
                    Color.clear
                        .onAppear {
                            let x = geometry.frame(in: .named("container")).minX
                            let y = geometry.frame(in: .named("container")).midY
                            closure(CGPoint(x: x, y: y))
                        }
                })
            }
    }
}

struct ViewPoint: View {
    
    @State private var points: [CGPoint] = []
    
    var body: some View {
        ZStack {
            path()
            
            HStack(content: {
                Circle()
                    .getPoint {
                        points.append($0)
                    }
                
                VStack(content: {
                    Circle()
                        .getPoint {
                            points.append($0)
                        }
                    Circle()
                        .getPoint {
                            points.append($0)
                        }
                    Circle()
                        .getPoint {
                            points.append($0)
                        }
                    
                    Text("Text")
                        .getPoint {
                            points.append($0)
                        }
                })
            })
        }
        .coordinateSpace(name: "container")
        .onChange(of: points) { oldValue, newValue in
            debugPrint("\(newValue)")
        }
    }
    
    private func path() -> some View {
        Path({ path in
            let startPoint = CGPoint(x: 0, y: 0)
            
            points.forEach {
                path.move(to: startPoint)
                path.addLine(to: $0)
            }
        })
        .stroke(.blue, lineWidth: 3)
        .zIndex(1)
    }
}

#Preview {
    ViewPoint()
}
