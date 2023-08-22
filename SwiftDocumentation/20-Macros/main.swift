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
