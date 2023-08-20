//
//  main.swift
//  Structures and Classes
//
//  Created by 노우영 on 2023/08/20.
//

import Foundation

//  MARK: Structures and Classes

//  다른 언어처럼 structure, class를 만들 때 별도의 파일을 만들지 않아도 된다.

//  클래스 인스턴스를 일반적으로 object라고 한다.
//  스위프트에서 구조체와 클래스를 다른 언어보다 상당히 비슷해서
//  인스턴스는 더 넓은 의미를 갖는다

//  MARK: Comparing structures and classes

/*
 공통점
 
 - store value
 - method
 - subscript
 - initializer
 - extend
 - conforms to protocol
 */

/*
 Class만 가능한 것
 - 상속
 - 런타임에서 타입 캐스팅
 - deinit
 - reference count
 */

/*
 기본적으로는 structure를 사용하고
 필요에 따라 클래스 사용
 */

//  MARK: Definition syntax

//  타입은 UpperCamelCsae
//  프로퍼티, 메소드는 lowerCamelCase
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}

//  MARK: Structure and Class Instances

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

//  MARK: Accessing properties

//  dot을 사용해 프로퍼티, 메소드에 접근
print("The width of someResolution is \(someResolution.width)")

//  MARK: Memberwise initializers for structure types

//  structure는 기본적인 이니셜라이저가 제공된다.
let vga = Resolution(width: 640, height: 480)

//  MARK: Structures and Enumerations Are Value Types

//  value type은 다른 메소드에 주입될 때 값을 복사한다.
//  스위프트의 collection의 모든 값을 복사하면 코스트가 크다.
//  origin의 값을 참조하다가 필요에 따라서 값을 카피 후 수정한다.

//  아래는 새로운 값이 cinema에 할당된다.
//  enum도 동일하다
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

//  MARK: Classes Are Reference Types

//  클래스타입은 값을 복사하지 않는다. 같은 값을 공유한다.

//  MARK: Identity operators

/*
 ===: 같은 인스턴스를 참조한다.
 !==: 다른 인스턴스를 참조한다
 */

//  MARK: Pointers

//  C처럼 포인터를 위해 *를 사용할 필요는 없고 다른 변수/상수를 만들 때 참조도 정의된다.
//  포인터를 다뤄야하면 Manual memory managerment 확인 
