//
//  main.swift
//  TheBasics
//
//  Created by wooyoung on 2023/08/17.
//

import Foundation

//  Int, Double, Float, String, Bool을 제공
//  Array, Set, Dictionary 제공

//  C보다 더 나은 constant 제공
//  Objective-C에는 없는, Tuple 제공.
//  Optional type 제공, class에서만 사용

//  type-safety, 잘못된 타입을 할당하는 것을 방지

//  MARK: Constant and Variables

let maximumNumberOfLoginAttepmts = 10
var currentLoginAttempt = 10

var x = 0.0, y = 0.0, z = 0.0

//  MARK: Type annotations

var welcomeMeesage: String
welcomeMeesage = "Hello"

var red, green, blue: Double

/*
 공식 문서에서는 값을 할당하면 타입을 알아서 추론해주기때문에 명시적으로 타입을 지정할 일은 없다고 하는데 타입 추론을 사용하는 것이 좋은지는 모르겠다.
 */

//  변수명은 모든 유니코드 문자가 가능하다.
//  공백은 포함할 수 없다.

let 파이 = 3.14
let 개와소 = "dogcow"

//  let 파이 = "delicious" 같은 이름은 사용 불가능.
//  다른 타입으로도 변환 불가능

let `struct` = "백틱으로 예약어 회피"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

//  MARK: Printing constants and variables

/*
 Xcode 콘솔에 출력을 보낸다.
 */
print(friendlyWelcome)

//  String interpolation
print("The current value of friendlyWelcome is \(friendlyWelcome)")

//  MARK: Comment

//  (//)를 이용해서 주석을 작성한다.

/*
 (/**/)를 이용해서
 여러줄의
 주석을
 작성한다.
 */

/*
 C와는 다르게
 /* 주석을 중첩할 수 있다. */
 */

//  MARK: Semicolons

//  스위프트는 기본적으로는 세미콜론이 필요하지 않지만
//  한 줄에 여러 코드를 작성하고 싶으면 구분을 위해 사용할 수 있다.
let cat = "cat"; print(cat)

//  MARK: Integers

//  siged-unsigned integer를 8, 16, 32, 64비트로 제공한다.

let minValue = UInt8.min // 최소값은 0
let maxValue = UInt8.max // 최대값은 255

//  Int, UInt의 비트는 운영체제 환경을 따라간다.
//  운영체제 32비트면, Int는 32비트
//  운영체제가 64비트면 Int도 64비트다.

//  플랫폼에 맞는 비트 수가 필요한게 아니면 UInt는 사용하지 않는 것을 권장한다.
//  음수가 필요 없는 경우라도 Int 사용을 권장한다.

//  MARK: Floating-Point numbers

//  Float은 32비트 Double은 64비트
//  Double의 Precision은 15, Float은 6
//  정확성 측면에서 Double이 좋다

//  MARK: Type safety and Type inference

/*
 Swift는 Type-safe 언어로 맞지 않은 타입의 값을 할당할 수 없다.
 컴파일 시에 타입을 확인한다.
 모든 변수에 타입을 지정할 필요는 없고 스위프트가 적절한 타입을 추론해준다.

 초기값이 있는 변수 상수를 선언할 때 타입추론이 유용하다.
 */

// Int로 추론된다.
let meaningOfLife = 42

// Double로 추론된다. 추론할 수 있는 타입 중에서 가장 큰 값으로 추론한다.
var pi = 3.14156

//  MARK: Numeric literals

// 숫자의 문법.

/**
 10진수: prefix X
 2진수 : 0b
 8진수: 0o
 16진수: 0x
 */

let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

// Float은 Decial, hexadecimal 가능
// Decimal은 exponent를 갖을 수 있다.

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1 // 1.21875 * 10^1
let exponentDouble2 = 1.25e-2 // 1.25 * 10^(-2)
let hexadecimalDobue = 0xFp2 // 15(F) * 2^2

// 가독성을 위해 언더바를 사용한다.
let paddedDouble = 000123.456
let oneMillioin = 1_000_000
let justOverOneMillon = 1_000_000.000_000_1

//  MARK: Numeric type conversion

// 기본적으로 정수를 표현할 때는 Int를 사용하자.
// 이는 스위프트가 정수를 기본적으로 Int로 추론해서 그렇다.
// 메모리나 최적화, 성능 같은 필요한 이유가 없다면 Int 사용.

//  MARK: Integer conversion

// let cannotBeNegative: UInt8 = -1 에러.

// let tooBig: Int8 = .max + 1 오버플로우 발생. 에러

// 타입이 다른 경우 연산할 수 없다.
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousnadAndOne = twoThousand + UInt16(one)

//  MARK: Integer and Floating point conversion

//  Int는 Dobule로 변한된다.
//  Numeric 연산은 항상 같은 타입으로.
let three = 3
let pointOneFourOneFiveNine = 0.14159
pi = Double(three) + pointOneFourOneFiveNine

//  실수를 정수변환 할 때는 소수점 아래가 사라진다.
let integerPi = Int(pi)

//  MARK: Type aliases

// 기존에 있는 타입에 새로운 이름을 줄 때 사용한다.
typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

//  MARK: Booleans
let orangesAreOrange = true
let turnipsAreDelicious = false

// bool은 조건문과 사용한다

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

//  MARK: Tuple

let http404Error = (404, "Not Found")

// Tuple decompose
let (statusCode, statusMessage) = http404Error

print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

// index를 이용해 튜플에 접근한다
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

// 튜플의 요소에 이름을 지정한다
let http200Status = (statusCode: 200, description: "OK")


print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

/*
 Tuple은 함수의 반환값으로 사용할 때 유용하다.
 간단한 값을 조합할 때만 사용하자.
 값이 크고 많다면 class, structure를 사용한다.
 */

//  MARK: Optionals

// C와 Objectvie-C에는 없는 개념.
// nil은 클래스뿐 아니라 구조체와 열거형에도


/*
 String을 Int로 변환할 때 가능할 수도 불가능할 수도 있다.
 불가능할 경우 nil을 반환한다.
 */
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

var serverResponseCode: Int? = 404
serverResponseCode = nil

/*
 Swift의 nil은 Objective-C의 nil과는 다르다.
 Objective-C의 nil은 포인터고
 Swift nil은 포인터가 아니다.
 */

//  MARK: If statements and Forced unwrapping

if convertedNumber != nil {
    print("convertedNumber contains some integer value")
}

// 값이 optional이 아니라고 확신할 때 !를 사용해 값을 가져올 수 있다.
// 이는 런타임 에러가 발생할 우려가 있다.
// 항상 확신가능 할 때만 !를 사용하자
if convertedNumber != nil {
    print("convertedNumber has an interger value of \(convertedNumber!)")
}

//  MARK: Optional binding


//  Int(possibleNumber)가 실제 값을 가질 경우 이를 actualNumber에 할당한다.
//  할당된 값은 if문 내에서 이용할 수 있다.
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an inter value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn`t be converted to an integer")
}

//  Optional binding을 할 때 같은 이름을 사용해도 된다.
let myNumber = Int(possibleNumber)

if let myNumber = myNumber {
    print("My number is \(myNumber)")
}

// 위 코드를 더 줄일 수 있다.
if let myNumber {
    print("My number is \(myNumber)")
}

// optional binding한 값을 if문 밖에서 사용하고 싶은 경우 guard 문을 사용하자.


//  MARK: Implicitly unwrapped optionals

// 반드시 값이 있을 경우에 사용한다.
// nil이 될 우려가 있는 경우에는 사용하지 말자
// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Unowned-References-and-Implicitly-Unwrapped-Optional-Properties

// 이 경우에는 사용된다.
let possibleString: String? = "An optional String"
let forcedStrigg: String = possibleString!

let asuumedString: String! = "An implicitly unwrapped optional string"
let implicitString: String = asuumedString


//  MARK: Error handling

func canThorwsAnError() throws {
    
}

do {
    // 에러를 반환할 수 있는 함수는 try 키워드와 함께 사용한다.
    try canThorwsAnError()
} catch {
    // 에러는 catch문 내부에서 처리된다.
}

func makeASandwich() throws {
    
}


func buyGroceries(_ ingredients: [String]) {
    
}

do {
    try makeASandwich()
} catch SandwichError.missingIngredient(let ingredient) {
    buyGroceries(ingredient)
}

// enum을 활용해 error에 associatedValue를 사용
enum SandwichError: Error {
    case missingIngredient([String])
}

//  MARK: Assertion and preconditions

/*
 런타임에 발생하는 일을 확인한다.
 예상 못한 경우가 발생하는 경우를 확인하고 싶을 때 이용.
 Assertion은 디버깅 때, precondition은 디버깅+프로덕트 빌드 때 이용된다.
 */

//  MARK: Debuggin with assertions

let age = -3
assert(age >= 0, "A person`s age can`t be less than zero")

if age > 0 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can rider the ferris wheel.")
} else {
    
    // 이미 조건을 검사한 경우에 사용한다.
    assertionFailure("A person`s age can`t be less than zero")
}

//  MARK: Enforcing preconditions

