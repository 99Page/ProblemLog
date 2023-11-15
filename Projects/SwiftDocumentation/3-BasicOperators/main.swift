//
//  main.swift
//  BasicOperators
//
//  Created by wooyoung on 2023/08/18.
//

import Foundation

/*
 산술연산자는 오버플로우를 감지한다.
 */

//  MARK: Terminology

/*
 Unary: 단항연산
 Binray: 이항연산
 Ternary 삼항연산
 */

//  MARK: Assignment operator
let b = 10
var a = 5
a = b

let (x, y) = (1, 2)

// C와는 다르게 = 연산이 값을 반환하지 않는다
//if x = y {
//
//}

//  MARK: Arithmetic operator

/*
 +
 -
 *
 /
 
 4가지 연산이 있고 오버플로우는 허용하지 않는다.
 문자열에 + 연산이 가능하다.
 */

let hello = "hello, "
let world = "world"
let helloWorld = hello + world

//  MARK: Remainder operator

//  Swift에서는 modulo 대신 remainder라고 한다.
//  a % b = c는 아래처럼 해석된다
//  a = (b * some multiplier) + c
//  -9 % 4 = -1 이다
//  -9 = (4 * -2) -1
//  a % b == a % -b
//  a % b != -a % b

//  MARK: Unary minus operator
let three = 3
let minusThree = -three
let plusThree = -minusThree

//  MARK: Unary micus operator
//  실제로 무슨 처리를 해주진 않는다
let minusSix = -6
let alsoMinusSix = +minusSix

//  MARK: Compound assignment operators

//  C처럼 할당과 unary를 결합할 수 있다
var first = 1
first += 2

// 이런식으로 사용 불가능하다.
// let b = a += 2

//  MARK: Comparison operator

/*
 Equal to: a == b
 Not eqaul to: a != b
 Greater than: a > b
 less than: a < b
 greater than or equal to: a >= b
 less than or eqaul to: a <= b
 참조 연산: a === b
          a !== b
 */

//  비교는 첫번째 element부터 진행된다.
//  1은 2보다 작아서 이후 연산되지 않는다.
let oneAndZebra = (1, "zebra")
let twoAndApple = (2, "apple")
oneAndZebra < twoAndApple // true

//  element의 값이 같은 경우는 다음 element를 비교한다.
//  apple은 bird보다 사전 순으로 앞에 오니 true다
let threeAndApple = (3, "apple")
let threeAndBird = (3, "bird")
threeAndApple < threeAndBird // true


//  equal은 모든 element가 같아야한다.
let fourAndDog = (4, "dog")
fourAndDog == fourAndDog // true

//  Swift standard library의 튜플 연산은 7개까지만 된다.

//  MARK: Terneary conditional operator

let contentHeight = 40
let hasHeader = true
var rowHeight: Int

if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}

//  위 코드를 삼항연산자로 아래처럼 줄인다
rowHeight = contentHeight + (hasHeader ? 50 : 20)

//  MARK: Nil-Coalescing operator

//  optional에 값이 있는 경우에는 그 값을, 값이 없는 경우에는 ?? 뒤의 값을 사용한다
let defaultColorName = "red"
var userDefinedColorName: String?

//  userDefinedColorName은 nil이라 뒤의 defaultColorName을 사용
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"

//  userDefinedColorName은 nil이 아니라 userDefinedColorName을 사용
colorNameToUse = userDefinedColorName ?? defaultColorName

//  MARK: Closed range

//  a...b은 a와 b를 모두 포함한다
//  rande는 for-in에서 유용하다
for index in 1...5 {
    print("\(index) times 5 is \(index*5)")
}

//  MARK: Half-open range operator

//  a..<b는 a는 포함, b는 포함하지 않는다.
//  배열탐색처럼, 0부터 시작하는 경우에 유용하다

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i+1) is called \(names[i])")
}

//  MARK: One-sided ranges

// 배열의 2번째 인덱스부터 접근한다
for name in names[2...] {
    print(name)
}

// 배열의 2번째 인덱스까지 접근한다
for name in names[...2] {
    print(name)
}

//  half-open 역시 사용된다.
//  이 경우 마지막 값에는 접근하지 않는다.
//  코드 가독성 측면에서 좋지 않아 보인다.
//  consistency를 위해 one-sided range는 사용하지 말자
for name in names[..<2] {
    print(name)
}

//  subcript외에도 onesided range를 사용할 수 있다.
//  아래의 경우에는 for-loop에서는 사용하기 어렵다. 범위가 정확하지 않다.
let range = ...5
range.contains(7) // false
range.contains(4) // false
range.contains(-1) // true

//for _ in range {
//
//}

//  MARK: Logical operators
//  boolean 값에 사용되는 연산자

/*
 !
 &&: 두 값이 true면 true. 앞의 값이 false면 뒤의 값은 연산하지 않는다. (short-circuit)
 ||: 한 값이라도 true면 true. 앞에 값이 true면 뒤의 값은 연산하지 않는다. (short-circuit)
 */

let allowedEntry = false
if !allowedEntry {
    print("ACESS DENIED")
}

let enteredDoorCode = true
let passedRetinaScan = false

//  passedRetinaScan이 false기 떄문에 뒤의 값은 확인하지 않는다.
if passedRetinaScan && enteredDoorCode {
    print("Welcome!")
} else {
    print("Access denied")
}

let hasDoorKey = false
let knowsOverridePassword = true

//  knowsOverriedPassword가 true라 뒤는 확인하지 않는다.
if knowsOverridePassword || hasDoorKey {
    print("Welcome!")
} else {
    print("Access denied")
}

//  MARK: Explicit parentheses
//  가독성을 위해 사용한다.

//  ()를 없애고 결과가 달라지진 않는다. 대신 의도가 명확해진다.
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("Access denied")
}

