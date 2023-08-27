//
//  main.swift
//  Advanced Operators
//
//  Created by 노우영 on 2023/08/27.
//

import Foundation

//  MARK: Advanced operators

/*
 스위프트는 복잡한 연산을 위해 몇가지 연산자를 더 제공한다.
 
 C의 산술연산자(arithmetic operator)와 달리 스위프트는 기본적으로 오버플로우가 발생하지 않는다.
 오버플로우는 에러로 취급된다.
 
 오버플로우를 허용하는 연산을 쓰려면 &와 같이 사용한다.
 */

// 에러 발생
// let doNotOverflow = Int.max + 1

let overflow = Int.max &+ 1 // 에러 없음

/*
 스위프트는 prefix, infix, postfix, assignment operator를 커스텀하는데 제한을 두지 않는다.
 
 */

//  MARK: Bitwise operators

/*
 데이터에 있는 bit를 연산할 때 사용한다.
 */

//  MARK: Bitwise not operator

/*
 prefix에 ~ 사용
 0과 1을 반전
 */

let initialBits = 0b00001111
let invertedBits = ~initialBits // 0b11110000

//  MARK: Bitwise and operator

/*
 같은 자리의 비트를 연산해서
 11 = 1 / 01 = 0 / 10 = 0 / 00 = 0
 */

let firstBits = 0b1001
let secondBits = 0b1100
let andBits = firstBits & secondBits // 0b1000

//  MARK: Bitwise or operator

/*
 같은 자리의 비트를 연산해서
 11 = 1 / 01 = 1 / 10 = 1 / 00 = 0
 
 둘중 하나만 1이여도 1.
 */

let firstORBits = 0b1001
let secondORBits = 0b1100
let orBits = firstORBits | secondORBits // 0b1101

//  MARK: Bitwise xor operator

/*
 같은 자리의 비트를 연산해서
 서로 다른 경우는 1
 */

let firstXORBits = 0b1001
let secondXORBits = 0b1100
let xorBits = firstXORBits ^ secondXORBits // 0b0101

//  MARK: Bitwise left and right shfit operator

/*
 한 비트식 좌측 혹은 우측으로 옮기는 연산
 <<
 >>
 
 곱하기와 나눗셈처럼 이용 가능
 */

//  MARK: Shifting behavior for unsigned intergers

/*
 1. 위치를 왼쪽 혹은 오른쪽으로 옮긴다.
 2. bound를 넘어서는 비트는 버린다.
 3. 빈 자리에는 0 비트가 들어간다.
 */

var leftShiftUnsignedBits: UInt8 = 0b0001_0000
leftShiftUnsignedBits =  leftShiftUnsignedBits << 2 // 0b0100_0000
leftShiftUnsignedBits = leftShiftUnsignedBits << 1 // 0b1000_0000
leftShiftUnsignedBits = leftShiftUnsignedBits << 1 // 0b0000_0000

/*
 다른 데이터를 인코딩, 디코딩할 때 사용할 수 있다.
 */

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16 // 0xCC = 0x0000CC
let greenComponent = (pink & 0x00FF00) >> 8 // 0x66
let bludComponent = (pink & 0x0000FF) // 0x99

//  MARK: Shifting behavior of signed intergers

/*
 Signed  bit의 msb는 sign bit라서 unsigned 보다 연산이 조금 복잡하다
 
 음수를 만드는 방법 = 양수 비트 뒤집기 + 1 (2의 보수법)
 
 시프트를 할 때 빈자리는 sign비트로 채워진다.
 */

var leftShiftSignedInterger: Int8 = 0b0100_0000
print(leftShiftSignedInterger) // 64. 0b0100_0000

leftShiftSignedInterger = leftShiftSignedInterger << 1
print(leftShiftSignedInterger) // -128. 0b1000_0000
//  2의 보수법 확인

//  0b0111_1111
//  0b1000_0000 = 128
//  sign bit 무시하고 연산

//  MARK: Overflow operator

/*
 &와 함께 사용하면 오버플로우 가능
 */

let overflowEnable = Int.max &+ 1

//  MARK: Operator methods

//  각 타입마다 연산자를 커스텀할 수 있다

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

let v1 = Vector2D()
let v2 = Vector2D()
// let v3 = v1 + v2 연산 정의안돼서 불가능

struct Vector2DWithOperator {
    var x = 0.0
    var y = 0.0
    
    static func + (left: Vector2DWithOperator, right: Vector2DWithOperator) -> Vector2DWithOperator {
        Vector2DWithOperator(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2DWithOperator()
let anotherVector = Vector2DWithOperator()
let combinedVector = vector + anotherVector

//  MARK: Prefix and postfix operators

extension Vector2DWithOperator {
    
    //  prefix, postfix는 지정을 해줘야한다
    static prefix func - (vector: Vector2DWithOperator) -> Vector2DWithOperator {
        return Vector2DWithOperator(x: -vector.x, y: -vector.y)
    }
}

//  MARK: Compound assignment operators

/*
 =와 다른 연산자 결합
 ex) +=
 */

extension Vector2DWithOperator {
    static func += (left: inout Vector2DWithOperator, right: Vector2DWithOperator) {
        left = left + right
    }
}

var original = Vector2DWithOperator()
let vectorToAdd = Vector2DWithOperator()
original += vectorToAdd

/*
 =
 ? : (삼항연산자)
 두가지는 오버라이딩 불가능
 */

//  MARK: Equivalence operators

/*
 ==를 정의하는 두가지 방법
 1. 직접 오버라이딩하기
 2. Equtable 프로토콜 준수하기
 
 개인적으로는 후자가 좋음.
 다른 기능들은 사용할 때 Equatable을 요구하는 상황이 많음.
 
 Equtable을 준수하면 기본적으로
 내부 모든 프로퍼티가 같으면 같은걸로 판단.
 필요에 따라 오버라이딩
 */

extension Vector2DWithOperator: Equatable {
    
}

//  MARK: Custom operators

prefix operator +++

extension Vector2DWithOperator {
    static prefix func +++ (vector: inout Vector2DWithOperator) -> Vector2DWithOperator {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2DWithOperator(x: 1.0, y: 2.0)
toBeDoubled = +++toBeDoubled

//  MARK: Precedence for custom infix operators

infix operator +-: AdditionPrecedence // 덧셈과 같은 우선순위
infix operator +*: MultiplicationPrecedence // 곱하기와 같은 우선순위


//  MARK: Result builders

protocol Drawable {
    func draw() -> String
}

/*
 다른 Drawable 타입을 이용하는 최종적인 Drawable 타입.
 다른 타입의 결과를 합쳐야한다. (maps 이용)
 */
struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Text: Drawable {
    var content: String
    init(_ content: String) { self.content = content }
    func draw() -> String { return content }
}

struct Space: Drawable {
    func draw() -> String { return " " }
}

struct Stars: Drawable {
    var length: Int
    func draw() -> String { return String(repeating: "*", count: length) }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String { return content.draw().uppercased() }
}

let name: String? = "Ravi Patel"

//  이 코드는 읽기 어렵다. 특히 AllCaps의 ?? 부분
let manualDrawing = Line(elements: [
     Stars(length: 3),
     Text("Hello"),
     Space(),
     AllCaps(content: Text((name ?? "World") + "!")),
     Stars(length: 2),
])
print(manualDrawing.draw())
// Prints "***Hello RAVI PATEL!**"

@resultBuilder
struct DrawingBuilder {
    static func buildBlock(_ components: Drawable...) -> Drawable {
        return Line(elements: components)
    }
    
    //  아래 두 메소드는 if-else를 위해서 사용한다.
    static func buildEither(first: Drawable) -> Drawable {
        return first
    }
    
    static func buildEither(second: Drawable) -> Drawable {
        return second
    }
}

func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return content()
}
func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return AllCaps(content: content())
}


func makeGreeting(for name: String? = nil) -> Drawable {
    let greeting = draw {
        Stars(length: 3)
        Text("Hello")
        Space()
        caps {
            if let name = name {
                Text(name + "!")
            } else {
                Text("World!")
            }
        }
        Stars(length: 2)
    }
    return greeting
}
let genericGreeting = makeGreeting()
print(genericGreeting.draw())
// Prints "***Hello WORLD!**"


let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())
// Prints "***Hello RAVI PATEL!**"

let capsDrawing = caps {
    let partialDrawing: Drawable
    if let name = name {
        let text = Text(name + "!")
        partialDrawing = DrawingBuilder.buildEither(first: text)
    } else {
        let text = Text("World!")
        partialDrawing = DrawingBuilder.buildEither(second: text)
    }
    return partialDrawing
}

extension DrawingBuilder {
    static func buildArray(_ components: [Drawable]) -> Drawable {
        return Line(elements: components)
    }
}
let manyStars = draw {
    Text("Stars:")
    for length in 1...3 {
        Space()
        Stars(length: length)
    }
}
