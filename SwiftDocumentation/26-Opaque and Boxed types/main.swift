//
//  main.swift
//  Opaque and Boxed types
//
//  Created by wooyoung on 2023/08/25.
//

import Foundation

//  MARK: Opaque and Boxed types

/*
 value type을 숨기기 위한 방법
 - opaque type
 - boxed protocol type
 
 opaque type
 concrete type을 반환하는 대신 protocol을 반환
 type identify를 보존한다(preserve)
 컴파일러는 타입에 접근할 수 있다.
 
 boxed protocol type
 주어진 프로토콜 타입의 모든 인스턴스를 저장한다
 type identify를 보존하지 않는다
 구체적인 타입을 런타임까지 알 수 없고 계속 바뀐다.
 */

//  MARK: The problem that opaque types solve

protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    
    func draw() -> String {
        var result: [String] = []
        
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        
        return result.joined(separator: "\n")
    }
}

let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())
// *
// **
// ***

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())
// ***
// **
// *

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
       return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())
// *
// **
// ***
// ***
// **
// *

//  MARK: Returning an opaque type

/*
 opaque type은 제너릭의 반대로 생각하면 된다.
 Generic 타입을 이용해서 함수의 패러미터, 반환값, 프로퍼티 타입을 원하는대로 받을 수 있었다.
 */

struct Square: Shape {
    var size: Int
    
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

//  Shape 타입을 반환하는 함수
//  concrete type 대신 protocol을 반환
//  some 없이도 사용 가능

//  모듈화 했을 때 모듈을 사용하는 클라이언트쪽에 concrete type을 숨긴다.
func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(top: top,
                                bottom: JoinedShape(top: middle,
                                                    bottom: bottom)
    )
    
    return trapezoid
}

func shape(value: Bool) -> Shape {
    if value {
        return Triangle(size: 5)
    } else {
        return Square(size: 5)
    }
}

let trapezoid = makeTrapezoid()
print()
print(trapezoid.draw())

//  generic과 opaque type 같이 사용하기
func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}

func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}


//  아래는 컴파일 에러 발생
//  Square와 FlippedShape는 서로 다른 타입
//  같은 타입만 반환해야한다
//  some을 제거하면 문제가 없다
//  문서에는 없지만 some/any를 사용하지 않을 경우 알아서 추론해주는 것 같다.

//func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
//    if shape is Square {
//        return shape // Error: return types don't match
//    }
//
//    return FlippedShape(shape: shape) // Error: return types don't match
//}


//  MARK: Boxed protocol types

//  boxed protocol type = existential type

struct VerticalShapes: Shape {
    
    //  boxed protocol type은 any 사용
    //  any의 타입은 같은 프로토콜은 준수하지만 다른 concrete type을 저장할 수 있다.
    
    //  제너릭을 사용할 경우 type을 직접 지정하고 모두 같은 타입이어야한다. type identity는 visible.
    //  [some Shape]는 모두 같은 타입 type identity는 hidden
    
    //  type identity = 타입의 이름
    
    var shapes: [any Shape]
    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n\n")
    }
}

let largeTriangle = Triangle(size: 5)
let largeSquare = Square(size: 5)
let vertical = VerticalShapes(shapes: [largeTriangle, largeSquare])
print(vertical.draw())

//  MARK: Difference between opaque types and boxed protocol types

/*
 둘의 핵심적인 차이는 type identity preserver의 유무
 opaque type이 type identity를 보존하는 이유는?
 다른 타입을 반환하는지 판단해야하니까
 
 opaque type끼리는 == 연산 가능. 타입이 같으니까
 boxed protocol type은 == 연산 불가능. 타입 같은지 모르니까 
 */

func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }


    return FlippedShape(shape: shape)
}

//  protocol은 == 연산 사용 불가능
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
//protoFlippedTriangle == sameThing  // Error

//  아래는 안된다는데..
let newProtoFlip = protoFlip(protoFlip(smallTriangle))

//  Container는 associated type이 있어 return type으로 사용 불가능
protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Array: Container { }

func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}
