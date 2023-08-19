//
//  main.swift
//  Functions
//
//  Created by 노우영 on 2023/08/19.
//

import Foundation

/*
 parameter에 기본값을 사용할 수 있다.
 모든 함수는 parameter type, return type을 갖는다.
 
 */

//  MARK: Defining and calling functions

//  함수는 함수명, parameter(argument), return type으로 구성된다

//  MARK: Function Parameters and Return Values


//  함수의 반환값 무시하기
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

//  MARK: Functions with Multiple Return Values

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}


//  MARK: Functions With an Implicit Return

//  함수 내부의 코드가 한줄이면 return을 생략하고 반환값을 작성할 수 있다,
//  한줄에는 반환해야하는 값이 작성되어야 하니 print 같은 코드는 작성하면 안된다.
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}

func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}

//  MARK: Function Argument Labels and Parameter Names

//  함수에는 argument명과 parameter명이 같이 작성된다.
//  기본적으로 argument와 parameter명은 동일하다
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)

//  from, hometown처럼 argument, parameter명을 분리할 수 있다.
//  argument명이 앞에 온다.
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))

//  underscore(_)를 사용해 argument 생략할 수 있다
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)

//  함수의 패러미터 타입 다음에 기본값을 사용할 수 있다.
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
}

//  MARK: Variadic parameter

//  ...를 활용해 해당 타입을 0개 이상으로 받을 수 있다.

func arithmeticMean(_ numbers: Double...) -> Double {
    //  내부적으로는 배열로 처리되는거 같은데 이럴거면 배열 사용이 낫지 않나..?
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1, 2, 3, 4, 5) // 타입은 한개가 작성됐는데 5개를 주입하는 코드

//  MARK: inout parameter

/*
 함수의 paramter는 constant고, 값을 바꾸려고 하면 compile error가 발생한다.
 parameter 값을 바꾸고 함수가 끝난 후에도 값을 유지할 때 inout 사용
 */

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  MARK: Function Types

/*
 함수도 일종의 타입이다.
 함수의 패러미터와 리턴타입이 함수의 타입을 구성한다.
 */

//  아래 두 함수는 타입이 같다.
//  (Int, Int) -> Int
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

//  struct, class, enum 타입처럼 함수 타입도 타입처럼 사용한다.
var mathFunction: (Int, Int) -> Int = addTwoInts
print(mathFunction(2, 3))

mathFunction = multiplyTwoInts
print(mathFunction(2, 3))

//  MARK: Function Types as Parameter Types

//  함수 타입을, 함수 패러미터로 사용할 수 있다
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//  MARK: Function Types as Return Types

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

//  함수 타입을 리턴 타입으로 사용하기
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

//  MARK: Nested Functions

//  함수 내부에 함수 선언할 수 있다.
//  이렇게 선언된 함수는 해당 함수 내부에서만 접근 가능하다. 
func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
