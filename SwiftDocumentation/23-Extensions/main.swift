//
//  main.swift
//  Extensions
//
//  Created by wooyoung on 2023/08/23.
//

import Foundation

/*
 기존의 class, structure, enumeration, protocol에 새 기능을 더한다.
 다음 기능을 할 수 있다.
 
 - computed property, computed type property 추가
 - instance method, type method 추가
 - initializer 추가
 - subscript 정의
 - nested type 정의 및 사용
 - protocol 추가
 - protocol의 메소드에 기능 정의
 */

//  MARK: Extension syntax

protocol SomeProtocol {
    
}

class SomeType {
    
}

extension SomeType: SomeProtocol {
    
}

//  MARK: Computed properties

//  extension에 computed property 추가하기
//  stored property, property observer 추가는 안된다

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let marathon = 42.km + 195.m
print("A marathon is \(marathon) meters long")

//  MARK: Initializers

//  class에는 convenience initializer 정의만 가능하고
//  designated, deinitializer 추가는 안된다

//  value 타입에 사용할 경우 멤버와이즈 이니셜라이저, 디폴트 이니셜라이저 계속 이용 가능

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(), size: Size())


//  MARK: Methods

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

//  MARK: Mutating instance methods
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

//  MARK: Subscripts
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7

//  MARK: Nested types

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
