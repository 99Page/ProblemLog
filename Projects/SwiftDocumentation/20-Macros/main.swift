//
//  main.swift
//  Macros
//
//  Created by wooyoung on 2023/08/22.
//

import Foundation

//  MARK: Macros

/*
 컴파일 때 매크로를 소스 코드로 변환해서 코드 중복을 줄여준다.
 매크로의 inout, output 모드 스위프트의 문법 유효성을 보장한다.
 에러가 있으면 컴파일로가 알려준다.
 
 매크로는 두가지 종류가 있다.
 - Freestaning macros
 - Attached macros
 */

//  매크로는 스위프트 5.9 베타 기능으로 컴파일이 불가능해서
//  코드 없이 개념만 정리

//  MARK: Freestanding macros

//  값을 만들고 컴파일 타임에 액션을 수행한다.

func myFunction() {
    //  #function = myFunction(), 현재 함수의 이름을 호출
    print("Currently running \(#function)")
    #warning("Something`s wrong") // compile time warning
}

myFunction()

//  MARK: Attached macros

//  매크로 없는 버전
//  타입 프로퍼티의 이시녈라이저 호출이 중복적이다
struct SundaeToppings: OptionSet {
    let rawValue: Int
    static let nuts = SundaeToppings(rawValue: 1 << 0)
    static let cherry = SundaeToppings(rawValue: 1 << 1)
    static let fudge = SundaeToppings(rawValue: 1 << 2)
}

//  macros는 컴파일 안되서 패스 

/*
 OptionSet 매크로는 내부의 private enum을 읽고
 contant value를 생성해준다
 */


//@OptionSet<Int>
//struct SundaeToppings {
//    private enum Options: Int {
//        case nuts
//        case cherry
//        case fudge
//    }
//}

//  MARK: Macro declarations

/*
 매크로는 선언과 실행이 분리된다.
 아래 주석은 매크로 선언 예제
 */

// public macro OptionSet<RawType>() = #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")

// attached macros는 UpperCamelCase
// freestanding macross는 lowerCamelCase

// macros는 항상 public


//@attached(member)
//@attached(conformance)
//public macro OptionSet<RawType>() =
//        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")

//@freestanding(expression)
//public macro line<T: ExpressibleByIntegerLiteral>() -> T =
//        /* ... location of the macro implementation... */
