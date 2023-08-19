//
//  main.swift
//  Control Flow
//
//  Created by 노우영 on 2023/08/18.
//

import Foundation

/*
 while
 if
 guard
 switch
 break
 continue
 for-in
 defer
 */

//  MARK: For-In loops
let names = ["Anna", "Alex", "Brian", "Jack"]

// 배열 탐색
for name in names {
    print("Hello, \(name)!")
}

// 딕셔너리 탐색. 순서보장x
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let minuteInterval = 5
let minutes = 60

//  to가 사용될 경우 open
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print("\(tickMark)")
}
//  0, 5, 10, 15 ... 55

//  through가 사용될 경우 close
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    print("\(tickMark)")
}

//  MARK: While loop

// 얼마나 반복될지 모를 때 사용.
// 조건에 따른 반복
// 생략

//  MARK: Conditional statements
//  MARK: if

var temperatureInFrahenheit = 30
if temperatureInFrahenheit <= 32 {
    // if 문이 true일 경우 실행
    print("It`s very cold. Consider wearing a scarf. ")
} else {
    print("It`s not that cold. Wear a T-shirt.")
}

// if문을 더 여러갈래로 사용하기
temperatureInFrahenheit = 90

if temperatureInFrahenheit <= 32 {
    print("It`s very cold. Consider wearing a scarf.")
} else if temperatureInFrahenheit >= 86 {
    print("It`s really warm. DOn`t forget to wear sunscreen.")
} else {
    print("It`s not that cold. Wear a T-shirt")
}

//  if문을 이용해서 값을 할당하기. 새로운 버전에서는 되는거 같음
//let weatherAdvice = if temperatureInFrahenheit <= 0 {
//    "It's very cold. Consider wearing a scarf."
//} else if temperatureInFrahenheit >= 30 {
//    "It's really warm. Don't forget to wear sunscreen."
//} else {
//    "It's not that cold. Wear a T-shirt."
//}

//  MARK: Switch

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the Latin alphabet")
case "z":
    print("The last letter of Latin alphabet")
default:
    print("Some other character")
}

// expression form
//  아마 버전문제로 아래 코드는 안되는거 같다.
//let another: Character = "a"
//let message = switch another {
//case "a":
//    "The first letter of the Latin alphabet"
//case "z":
//    "The las letter of the Latin alphabet"
//default:
//    "Some ohter Character"
//}

//  MARK: No implicit fallthrough

//  C, Objective-C와 다르게 Swift의 case는 각 상태마다 break 해주지 않아도 된다.
//  하지만 실행하고 싶지 않으면 break 사용할 수 있다.

let anotherCharacter: Character = "A"
switch anotherCharacter {
case "a":
    //  break이 없으면 컴파일 에러
    break
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}

// case 합치기
switch anotherCharacter {
    
    // 여러줄로 만들 수 있음.
case "a",
    "A":
    print("the letter A")
default:
    print("Not the letter A")
}


//  MARK: Interval matching

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String

switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

//  MARK: Tuple

let somePoint = (1, 1)

//  _는 wildCard
//  C와는 다르게 여러 조건문에 해당해도 된다
//  0, 0이 해당되는 조건은 4가지가 있는데 그 중 첫번째로 실행된다.
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

//  MARK: Value Bindings

//  일시적으로 case 내부에서 값을 사용할 수 있다
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
    // 아래 case가 디폴트 케이스를 대체한다.
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

//  MARK: Where

//  추가적인 조건을 확인하기 위해 where절을 사용할 수 있다.
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

//  MARK: Compound Cases

let someCharacter2: Character = "e"

switch someCharacter2 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter2) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter2) is a consonant")
default:
    print("\(someCharacter2) isn't a vowel or a consonant")
}

//  binding과 compound 같이 사용
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

//  MARK: Control transfer statements

/*
 실행될 순서를 바꾸기
 cotinue
 break
 fallthrough
 return
 throw
 
 return과 throw는 다른 문서에서 다룬다.
 */

//  MARK: Continue

//  루프문에서 남은 코드를 실행하지 않고 다른 이터레이션 실행하기

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)

//  MARK: Break

/*
 loop와 switch에서 사용된다.
 
 loop: 모든 이터레이션 종료
 switch: 실행을 하고 싶지 않은 case에서 사용
 */

//  MARK: Fallthrough

/*
 스위프트에서는 기본적으로 하나의 케이스만 실행되는데(맨 위 케이스부터)
 여러 케이스를 실행하고 싶을 때는 fallthorught를 명시해준다.
 C 스타일로 스위치를 사용하는 방법이다.
 */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}

//  MARK: Early exit

//  guard문. if else return의 축약형

//  MARK: Defer action

//  {} 내부가 끝나고 실행되는 코드. 여러개의 defer가 있으면 처음 선언된게 마지막으로 실행된다
var score = 1
if score < 10 {
    defer {
        print(score)
    }
    defer {
        print("The score is:")
    }
    score += 5
}
// Prints "The score is:"
// Prints "6"

//  MARK: Checking api availibility

/*
 API 사용 가능성을 참고해서 배포 버전에서 사용 불가능한 API를 사용하는 것을 막을 수 있다.
 */

if #available(iOS 10, macOS 10.12, *) {
    
} else {
    
}

//  guard와 함께 사용 
func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
       return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}


