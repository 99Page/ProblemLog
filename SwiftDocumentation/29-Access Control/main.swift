//
//  main.swift
//  Access Control
//
//  Created by wooyoung on 2023/08/25.
//

import Foundation

//  MARK: Access control

/*
 다른 소스 파일이나 모듈로부터 코드 접근을 제한한다.
 
 entity: access control을 적용할 수 있는것들
 */

//  MARK: Modules and source files

/*
 스위프트의 접근 제한을 모듈롸 소스 파일을 기준으로 한다.
 (자바의 클래스와는 다르다)
 
 Module: 코드 배포의 단위. 프레임워크나 어플리케이션. 다른 모듈에 import되는 것들
 
 source file: 모듈 안의 하나의 .swift 파일. 하나의 파일에는 여러 타입, 메소드가 정의될 수 있다.
 */

//  MARK: Access levels

/*
 스위프트는 5개 수준의 access level을 제공한다.
 
 open/public: 다른 모듈에서도 접근 가능. 둘의 차이점은 아래에서 기술
 
 internal: 같은 모듈에서만 접근 가능.
 
 file-private: 같은 소스 파일에서만 접근 가능
 
 private: { } 내부와 같은 소스 파일의 extension에서 접근 가능.
 
 open은 클래스와 그 멤버에만 적용된다. 다른 모듈에서 상속과 오버라이딩이 가능하다.
 공개 수준은 open이 제일 크고 private이 제일 작다
 */

//  MARK: Guiding principle of access levels

/*
 internal type에 public variable을 가질 수 없다.
 
 function보다 공개 범위가 높은 parameter를 사용할 수 없다.
 */

//  MARK: Default access levels

/*
 access level을 지정하지 않으면 기본값은 internal
 */

//  MARK: Access levels for single-target apps

/*
 한개 모듈만 사용하면 public/open 사용할 필요 없다.
 그래서 default access level은 internal
 */

//  MARK: Acces levels for frameworks

/*
 프레임워크를 만들 때는 public/open 사용
 */

//  MARK: Access levels for unit test targets

/*
 테스트를 하기 위해서 앱의 기능을 공개해야된다.
 일반적으로는 public 사용해야한다.
 하지만 @testable을 이용해 import하면 internal에도 접근할 수 있다.
 */

//  MARK: Access control syntax

open class SomeOpenClass { }
public class SomePublicClass { }
internal class SomeInternalClass { }
fileprivate class SomeFileprivateClass { }
private class SomePrivateClass { }

//  MARK: Custom types

/*
 type의 access level은 해당 타입의 property, method에 영향을 준다.
 type이 fileprivate이면 프로퍼티 default access level은 fileprivate
 
 default access level이 internal보다 커지진 않는다
 */

public class SomePublicClass2 {
    public var somePublicProperty = 0
    var someInternalPorperty = 0 // implicitly internal
    fileprivate func someFilePrivateMethod() { }
    private func somePrivateMethod() { }
}

class SomeInternalClass2 {
    var someInternalProperty = 0 // implicitly internal
}

fileprivate class SomeFilePrivateClass2 {
    func someFilePrivateMethod() { } // implicitly file-private
}

private class SomePrivateClass2 {
    func somePrivateMethod() { } // implicitly
}

//  MARK: Tuple types

/*
 튜플의 원소가 다르면 낮은 레벨로 제한된다.
 */

//  MARK: Function types

/*
 function의 access level은 명시적으로 지정되어야한다.
 함수의 시그니처 중 가장 낮은 레벨의 타입으로 제한된다.
 */

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass(), SomePrivateClass())
}

//  MARK: Enumeration types

/*
 enum의 case는 enum과 동일한 접근수준
 각 case는 모두 같은 접근 수준
 */

public enum CompassPoint: Int  {
    
    //  아래는 모두 public
    //  rawValue도 모두 public
    case north
    case south
    case east
    case west
}

//  MARK: Nested types

/*
 nested type은 containing type과 같은 접근 수준
 public인 경우에는 명시적으로 작성
 */

//  MARK: Subclassing

/*
 subclass의 접근 수준은 superclass보다 높을 수 없음.
 */

public class A {
    fileprivate func someMethod() { }
}

internal class B: A {
    
    //  오버라이딩은 슈퍼클래스의 접근 수준보다 높을 수 있음
    override internal func someMethod() {
        
    }
}

//  MARK: Constants, variables, properties and subcripts

/*
 해당 타입보다 높을 수 없음
 */

//  internal로 선언 불가능
private var privateInstance = SomePrivateClass()

//  MARK: Getters and setters

/*
 constant, variable, property, subscript와 동일한 접근 수준을 갖는다.
 
 setter는 getter보다 낮은 접근 수준을 가질 수 있음.
 
 private(set) / private(set)
 */

struct TrackedString {
    
    // set은 private, ger은 internal (struct가 internal)
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value += "This string will be tracked" // 같은 파일이라 접근 가능
print(stringToEdit)

//  getter 접근 범위 추가
public struct TrackedString2 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//  MARK: Initializers

/*
 class와 접근 수준과 동일
 initialzer보다 낮은 수준의 패러미터 사용 불가능
 */

//  MARK: Default initializers

/*
 default initializer는 internal
 필요한 경우 명시적으로 작성
 */

//  MARK: Default memberwise initializers for structure types

/*
 memberwise initializer는 패러미터에 사용되는 타입의 수준을 따라감..
 custom initializer는 internal
 */

//  MARK: Protocols

/*
  protocol에 정의된 것들의 access level은 protocol과 동일
 프로토콜에서 다른 접근 수준 정의 불가능
 
 구조체/클래스와는 이런 점에서 다르다
 */

//  MARK: Protocol inheritance

/*
클래스 상속처럼, 하위 프로토콜은 상위 프로토콜보다 높을 수 없다.
 */

//  MARK: Protocol conformance

/*
 타입 보다 낮은 접근 수준의 프로토콜을 준수하는 것은 가능하다.
 */

//  MARK: Extensions

/*
 타입의 멤버처럼 extension의 멤버도 접근 수준은 타입과 동일하다.
 public/open 타입에 작성된 멤버는 internal
 
 extension에 타입과 다른 접근 수준 지정가능. 단 높을 수는 없다.
 
 protocol을 extension할 때는 접근 수준 지정 불가능
 */

//  MARK: Private members in extensions

/*
 private member를 선언하고 같은 파일에 있는 extension에서 접근 가능
 
 private member를 extension에 선언하고 같은 파일에 있는 다른 extension에서 접근 가능
 
 private member를 extension에 선언하고 같은 파일에 있는 원래의 타입에서 접근 가능
 */

protocol SomeProtocol {
    func doSomething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

//  MARK: Generics

/*
 제너릭의 접근 수준은 사용되는 타입 중 가장 낮은 수준으로 제한
 */

//  MARK: Type aliases

/*
 type alias는 원래 타입보다 높은 수준을 가질 수 없음. 
 */
