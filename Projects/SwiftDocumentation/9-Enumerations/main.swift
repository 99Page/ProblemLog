//
//  main.swift
//  Enumerations
//
//  Created by 노우영 on 2023/08/20.
//

import Foundation

//  MARK: Enumerations

//  예측되는 값들을 나열한 타입
//  C처럼 rawValue가 아니라 associatedValue 사용

//  MARK: Enumeration syntaax

//  C처럼 기본 integer 값을 갖지 않는다
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//  가로로 열거 가능
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//  MARK: Matching enumeration values with a switch statement

//  enum 타입 매칭으로 코드 실행
var directionToHead: CompassPoint = .south

switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

//  디폴트로 다른 타입 생략
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//  MARK: Iterating over Enumeration Cases

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count

//  정의된 순서대로 출력
for beverage in Beverage.allCases {
    print(beverage)
}

//  MARK: Associated values

//  다른 언어의 discriminated unions, tagged unions, variants와 유사

//  각 케이스는 다른 값을 가질 수 있다
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

//  let으로 값을 하나하나 뺄 수 있다
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//  모든 값을 빼려면 아래 문법처럼 가능하다
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

//  MARK: Raw values

//  Int에서 rawValue는 1씩 증가
//  값을 주지 않으면 시작값은 0
enum RawValueInt: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//  String에서 rawValue는 case와 동일
//  east의 rawvalue는 "east"
enum RawValueString: String {
    case north, south, east, west
}

//  MARK: Initializing from a Raw Value

//  rawValue가 없을수도 있으니 옵셔널로 반환
let value = RawValueInt(rawValue: 7)

//  MARK: Recursive enumerations

//  같은 enum 타입의 case를 associated value로 갖는 case

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum AnotherArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
