//
//  main.swift
//  Automatic reference counting
//
//  Created by wooyoung on 2023/08/25.
//

import Foundation

//  MARK: How ARC Works

/*
 클래스를 생성하면 ARC가 자동으로 메모리를 할당한다.
 더 이상 인스턴스가 사용되지 않으면 자동으로 메모리를 해제한다.
 
 실제로 사용되고 있는 인스턴스 메모리를 해제하면 크래쉬가 발생한다.
 이런 상황을 박기 위해 참조 수를 센다.
 
 이를 위해서 클래스를 프로퍼티, 변수 등에 사용할 때 마다 strong reference를 만든다.
 */

//  MARK: ARC in action

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

//  Print "Jone Appleseed is being initialized"
//  Person에 대한 Strong reference 1증가
reference1 = Person(name: "John Appleseed")

//  Persone에 대한 Strong reference 2증가
reference2 = reference1
reference3 = reference1

//  Person에 대한 reference를 reference3가 유지
reference1 = nil
reference2 = nil

//  Print "John Appleseed is being deinitialized"
reference3 = nil

//  MARK: String reference cycles between class instances

/*
 strong reference cylce: 서로 다른 두 클래스 인스턴스가 강한 참조를 하고 있는 경우
 이런 경우 weak/unowned로 해결
 */

class Person2 {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
    }
}

class Apartment {
    let unit: String
    var tenant: Person2?
    
    init(unit: String) {
        self.unit = unit
    }
    
    deinit {
        print("Apartment \(unit) is beinig deinitialized")
    }
}

var john: Person2?
var unit4A: Apartment?

//  Person2 reference count = 1 by John
john = Person2(name: "John Appleseed")

//  Apartment reference count = 1 by unit4A
unit4A = Apartment(unit: "4A")

// Apartment reference count = 2 by unir4A and john?.apartment
john?.apartment = unit4A

//  Person2 reference count = 2 by John and unit4A?.tenant
unit4A?.tenant = john

//  Person2 reference count = 1 by unit4A?.tenant
john = nil

//  Apartment reference count = 1 by john?.apartment
unit4A = nil

//  MARK: Resolving strong reference cycles between calss instacne

/*
 위에서 말한 것처럼 weak/unowned로 순환 참조 문제를 해결할 수 있다,
 참조는 하지만 reference count를 증가시키진 않는다.
 
 참조되는 인스턴스의 사용 시간이 짧을 때 weak 사용
 참조하는 인스턴스와 참조되는 인스턴스의 시간이 동일하면 unowned 사용
 */

//  MARK: Weak references

/*
 weak은 런타임에 nil로 변경될 수 있다. 항상 optional type
 */

class Person3 {
    let name: String
    var apartment: Apartment3?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment3 {
    let unit: String
    weak var tenant: Person3?
    
    init(unit: String, tenant: Person3? = nil) {
        self.unit = unit
        self.tenant = tenant
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john3: Person3?
var unit4A3: Apartment3?

//  Person3 RC = 1 by john3
//  Apartment3 RC = 1 by unit4A3
john3 = Person3(name: "John Appleseed")
unit4A3 = Apartment3(unit: "4A")

//  Apartment3 RC = 2 by unit4A3 and john?.apartment
john?.apartment = unit4A

//  Person3 RC = 1 by john3
//  tenant는 weak이여서 참조를 증가시키지 않는다.
unit4A?.tenant = john

//  Person3 RC = 0
//  Apartment3 RC = 1 by unit4A3
//  john에 의한 참조가 모두 사라진다
john = nil

unit4A3 = nil

/*
 tenant가 weak이라는 것은
 Person3가 Apartment3 보다 먼저 deinit된다는 뜻이다.
 */


//  MARK: Unowned references

/*
 weak과 비슷하지만 두 인스턴스의 lifetime이 동일할 때 사용
 weak과 달리 optional 사용 불가
 
 lifetiem이 다른 인스턴스에 사용 하면 런타임 에러 발생 우려
 */

/*
 Customer, CreditCard 예제와 Apartment, Person과 다른 점은
 CreditCard는 항상 Customer가 필요하단 점이다.
 */

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}


class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var johnCustomer: Customer? = Customer(name: "John Appleseed")
johnCustomer?.card = CreditCard(number: 1234_5678_9012_3456, customer: johnCustomer!)

johnCustomer = nil
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"

/*
 위 예제는 safe unowned references
 unsafe unowned reference도 존재한다
 */

//  MARK: Unowned optional references
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}


class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of plantes", in: department)
let intermediate = Course(name: "Growing comment herbs", in: department)
let advanced = Course(name: "Caring for tropical plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

//  MARK: Unowend references and implicitly unwrapped optional properties
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        
        //  self를 사용할 수 있는 경우는 모든 프로퍼티의 값이 할당됐을 때다.
        //  capitalCity는 값이 할당되지 않았으니 self를 사용할 수 없다.
        //  이때문에 !를 사용한다.
        //  이를 이용해서 Country와 City를 하나의 이니셜라이저로 만들 수 있다
        self.capitalCity = City(name: capitalName, country: self)
    }
}


class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//  MARK: String references cycles for closures

/*
 클로저를 프로퍼티에 할당할 때도 strong reference cycle이 발생한다.
 closure도 capture를 하는 reference type
 
 closure capture list를 사용해 이 문제 해결 가능
 */

class HTMLElement {
    let name: String
    let text: String?
    
    //  self를 여러번 참조하지만 rc는 1증가
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)<\(self.name)"
        } else {
            return "<\(self.name)"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

//  HTMLElement reference count = 2 by paragraph, asHTML()
//  asHTML() reference count = 1 by paragraph
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world!")
print(paragraph!.asHTML())

//  paragraph deinit되지 않음
paragraph = nil

//  MARK: Resolving string reference cycels for closures

/*
 capture list를 사용해서 문제 해결 가능
 
 클로저 내부에서 self를 참조할 때는 self 사용을 권장한다.
 */

//  MARK: Weak andunowned references

class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)"
        }
    }
    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }


    deinit {
        print("\(name) is being deinitialized")
    }

}



