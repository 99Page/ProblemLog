//
//  main.swift
//  Closure
//
//  Created by 노우영 on 2023/08/19.
//

import Foundation

//  MARK: Closure

/*
 클로저는 다른 언어의 람다와 비슷하다.
 클로저가 변수, 상수를 캡처해서 레퍼런스를 유지한다.
 
 global function, nested function 모두 클로저를 사용한 예시다.
 클로저는 아래 세개 중 한개를 실행한다.
 
 - global function은 이름이 있고 어떤 값도 캡처하지 않는다.
 - nested function은 이름이 있고 함수절 내부의 값을 캡처한다.
 - closure는 이름이 없는 간단한 문법 형태의 캡처고, 주변의 값들을 캡처한다.
 
 스위프트 클로저는 아래 같은 장점이 있다.
 - contenxt에서 패러미터, 반환 값 타입 추론
 - 단일식 암시적 반환
 - argument 명 축약
 - Trailing closure syntanx
 */


//  MARK: Closure expression

/*
 클로저 문법은 함수를 축약해서 쓰는데 이점이 있다.
 */

//  MARK: The sorted method

//  스위프트에 구현된 sorted(by:) 사용해보기
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

// sorted(by:)는 (String, String) -> Bool 타입이 필요하다.
var reversedNames = names.sorted(by: backward)

print(reversedNames)

//  MARK: Closure expression syntax

//  함수형태에서 조금 축약한 형태

//  타입을 먼저 써주고, in 내부에서 리턴값을 사용한다.
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//  MARK: Inferring type from context

//  스위프트는 내부에 사용되는 타입을 추론할 수 있다.
//  즉, String, String, Bool을 생략해도 된다.
//  아래는 타입을 생략했다
reversedNames = names.sorted(by: { s1, s2 in
    s1 > s2
})

//  MARK: Implicit returns from single-expression closures

//  in 내부가 한줄인 경우 return 생략할 수 있다,
reversedNames = names.sorted(by: { s1, s2 in
    s1 > s2
})

//  MARK: Shorthand argument names

//  argument 이름을 생략하고 $0, $1 형식으로 사용한다.
//  이때 in도 생략된다

//  초기 함수로 했을 때와 많이 줄어들었다.
reversedNames = names.sorted(by: { $0 > $1 })


//  MARK: Operator methods

//  스위프트의 스트링은 > 연산이 구현되어 있다.
//  이 연산의 타입은 (String, String) -> Bool이다
//  따라서 아래처럼 표현가능하다
reversedNames = names.sorted(by: >)

//  MARK: Trailing closures

//  클로저를 함수의 마지막 패러미터로 사용할 때 trailing closure가 유용하다
//  trailing clousre는 argument를 작성하지 않아도 된다.

func someFunctionThatTakesAClosure(closure: () -> Void) {
    
}

someFunctionThatTakesAClosure(closure: {
    //  후행이 아닐 경우 argument가 필요
})

someFunctionThatTakesAClosure {
    //  후행일 경우 생략 가능
}

//  MARK: Capturing values

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        
        //  이 함수는 runningTotal과 amount를 캡쳐한다.
        //  다른 함수에 패러미터로 전달될 때 이 값들이 함께 전달된다.
        //  incrementer만 독립적으로 살펴보면 이 함수는
        //  runningTotal, amount가 뭔지 모른다.
        //  내부에 값은 선언되지 않고 주변의 값을 참조는 하고 있을 때
        //  캡처라고 한다
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

//  클로저가 아니라면 값들은 참조가 아니라 값을 복사한다.

//  클래스의 프로퍼티가 클로저 타입이고, 이 클로저가 클래스 멤버를 참조한다면
//  순환 참조가 발생할 수 있는데
//  스위프트는 캡처 목록을 사용해 순환 참조를 제거한다.

//  MARK: Closures are reference type

/*
 아래 코드에서 incrementByServen은 constant다.
 하지만 클로저를 이용해서 runningTotal에 접근할 수 있는데 이는
 function과 closure는 reference type이기 떄문이다.
 function/closure를 다른 값에 할당하면
 그 때마다 참조값이 증가한다.
 */
let incrementBySeven = makeIncrementer(forIncrement: 7)

//  MARK: Escaping closure

/*
 argument로 들어온 클로저를 해당 함수 내에서가 아니라
 또 다른 함수에 argument로 전달할 때
 escape closure라고 한다. 
 */

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//  @escaping에서 self를 참조할 때는 강한 참조를 예방하기 위해 self를 명시해준다.

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        
        //  이 경우에는 명시적으로 self 없이도 참조가 암시적으로 사용된다
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

class someOtherClass {
    var x = 10
    
    func doSomething() -> Int {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
        
        return 100
    }
}


//  mutating method에는 self 불가능
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
//        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

//  MARK: Autuclosures

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

// 아래 코드는 함수 실행이 아닌 변수(함수) 할당.
// 실행되지 않는다
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )


//  { } 없이 패러미터에 사용할 수 있다
//  오토클로저의 과한 사용은 지양하자 
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
