//
//  main.swift
//  Initialization
//
//  Created by wooyoung on 2023/08/22.
//

import Foundation

//  MARK: Intialization

/*
 Objective-C의 이니셜라이저와 달리 스위프트의 이니셜라이저는 값을 반환하지 않는다.
 주요 역할은 사용되기 전에 초기화된 것을 보장하는 것
 */

//  MARK: Setting initial values for stored properties

//  기본값을 사용하면 프로퍼티 옵저버는 호출되지 않는다.

//  MARK: Initializers

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()

//  MARK: Default property values

//  같은 값이 필요할 경우 가독성때문에 디폴트 밸류 권장
struct FahrenheitWithDefaultValue {
    var temperature = 32.0
}

//  MARK: Customizing initiaization

struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenhit: Double) {
        temperatureInCelsius = (fahrenhit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//  MARK: Parameter names and argument labels

/*
 function처럼 분리가 가능.
 언더스코어도 가능
 */

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//  MARK: Optional property types

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

//  MARK: Assigning constant properties during initializaion

/*
 이니셜라이저로 값이 한번 할당되면 변경되지 않는다.
 */

class SurveyQuestionWithConstant {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestionWithConstant(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//  MARK: Default initializers
//  모든 프로퍼티에 기본값이 배정되면 default initializer 사용할 수 있다.

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


//  MARK: Memberwise initializer for structure type

/*
 커스텀 이니셜라이저를 만들지 않으면 구조체는 기본적인 이시녈라이저를 제공한다.
 디폴트 이니셜라이저와 달리 모든 프로퍼티를 패러미터로 사용한다.
 */

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
let zeroByZero = Size() // 디폴트 이니셜라이저

//  MARK: Initializer delegation for value types

/*
 이니셜라이저가 다른 이니셜라이저 호출
 value type, class type의 방식이 다르다
 
 value type은 self로 호출
 
 커스텀 이니셜라이저를 만들면 디폴트 이니셜라이저, 멤버와이즈 이니셜라이저에 접근 불가능
 (extension에 작성하면 접근 가능)
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        //  delegate
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//  MARK: Class inheritance and initialization

/*
 Designated initializer
 Convenience initialzier
 두가지 방법
 */

//  MARK: Designated initializer and convenience initializers

/*
 Designated: 모든 프로퍼티 초기화. 각 클래스는 하나의 designated를 가져아한다.
 convenience: 다른 클래스의 designated 호출
 */

//  MARK: Initializer delegation for class types

/*
 designated와 convenience 사이의 3가지 룰
 
 1. deisignate는 상위 클래스의 designated를 반드시 호출한다
 2. convenience는 같은 클래스의 이니셜라이저를 호출한다
 3. convenience는 최종적으로 하나의 designated를 호출한다
 */

//  MARK: Two-phase initialization

/*
 스위프트의 클래스 초기화는 2단계를 거친다
 
 1. 각 stored property가 초기값을 통해 할당된다. 이 과정이 끝나면 2단계가 시작된다.
 2. 초기값이 배정되면 각 값에 접근할 수 있고, 커스텀할 수 있다.
 
 위 과정을 통해 초기화되지 않는 값에 접근하는 것을 막는다.
 
 Objective-C는 페이즈1에서 zero, null을 프로퍼티에 배정한다.
 스위프트는 초기값 배정이 더 유연하다. 그 외에는 비슷하다.
 */

/*
 스위프트는 2페이즈 이니셜라이제이션을 위해 4가지 Safety check를 한다.
 
 1. Safety check1: designated는 해당 클래스의 모든 프로퍼티 초기화를 확인하고 슈퍼 클래스의 초기화를 호출한다.(delegate)
 
 2. Safety check2: 상속받은 프로퍼티에 값을 할당하기 전에 슈퍼클래스의 이니셜라이저를 호출해야한다.
 
 3. Safety check3: convenien로 값을 할당하기 전 다른 이니셜라이저를 호출해야한다. 그렇지 않을 경우 원하지 않은 값으로 덮어씌어진다.
 
 4. Safety check4: 초기화가 끝나기 전까지 instance method, property에 접근할 수 없다.
 */

/*
 Phase1의 동작 과정
 
 - designated/convenience가 호출된다
 - 인스턴스를 위한 메모리가 할당된다. 아직 초기화는 되지 않은 상태
 - designated가 호출된 경우 모든 값을 할당하고 초기화한다.
 - 같은 과정을 super class 이니셜라이저에서 동작한다.
 - 상속 체인을 끝낼 때 까지 반복.
 - base class 초기화가 끝나면 인스턴스 메모리는 완벽하게 초기화된다.
 */

/*
 Phase2의 동작 과정
 
 base initialization이 끝나면 self 프로퍼티에 접근 가능해서 수정 가능한 상태가 된다.
 */

//  MARK: Initializer inheritance and overriding

/*
 Objective-C처럼 스위프트는 슈퍼클래스의 이니셜라이저를 기본적으로 상속받지 않는다.
 */

class Vehicle {
    
    //  default initializer 제공
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    
    //  custom init
    //  상위클래스의 designated와 일치
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    
    init(color: String) {
        self.color = color
        //  해당 클래스의 프로퍼티가 모두 할당되면
        //  암시적으로 super.init 호출
    }
    
    override var description: String {
        return "\(super.description) in a beautiful color \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("hoverboard: \(hoverboard.description)")

//  MARK: Automatic initializer inheritance

/*
 subclass는 기본적으로 supclass의 initializer를 상속받지 않는다.
 하지만 특정 조건에서는 상속된다.
 
 서브클래스에 새로운 프로퍼티를 추가했다면 다음 두가지 규칙이 적용된다.
 
 - Rule1: 서브클래스에 designated를 정의하지 않으면 상속받는다.

 - Rule2: 서브클래스에 모든 슈퍼클래스의 designated에 대한 구현을 제공하면 슈퍼클래스의 모든 convenience를 상속받는다.
 
 서브클래스는 슈퍼클래스의 designated는 subclass의 convenience로 실행할 수 있다.
 */

//  MARK: Designated and convenience initializers in action

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        
        super.init(name: "name") // default init이 아니기때문에 명시적으로 사용
    }
    
    //  슈퍼클래스의 designated와 동일.
    //  override된 경우 super호출 안한다.
    //  Food의 모든 designated를 상속했받았으니
    //  Food의 모든 convenience도 상속받는다.
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

/*
 이시녈라이저가 필요한 프로퍼티가 없어서
 상위클래스의 이니셜라이저를 상속받는다
 */
class ShoppingListItemWithClass: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

//  MARK: Failable initializers

/*
 Init?
 
 Init과 Init? 을 같은 패러미터로 선언할 수 없다.
 */

/*
 이니셜라이저는 값을 반환하지 않는다.
 초기화를 보장해주는 역할을 한다.
 */


let wholeNumber: Double = 12345.0
let pi = 3.14159


if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

//  MARK: Failable initializers for enumerations

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

//  MARK: Propagation of initialization failure

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

// failable을 non-failable로 오버라이딩할 수 있다. 그 외는 안된다.

//  MARK: Required iniailizers

class SomeClass {
    
    //  모든 하위 클래스는 이 이니셜라이저를 실행해야 한다.
    required init() {
        
    }
}

class SomeSubclass: SomeClass {
    
}

//  MARK: Setting a default property value with a closure or function

/*
 프로퍼티 기본값을 커스텀하고 싶을 때 closure, global function 이용 가능
 
 */

class SomeClassWithDefaultProperty {
    let someProperty: Int = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return -1
    }()
    
    //  클로저 다음에 오는 () 는 클로저를 즉시 실행하게 만든다.
    
    //  클로저를 통해 초기화할 때 다른 값들은 아직 초기화되지 않는 상태다.
    //  즉 클로저 내부에서 다른 프로퍼티에 접근하지 못한다.
}

//  사용 예제
//  기본값으로 많은 양이 담기는 콜렉션의 경우
//  코드로 초기값을 줄 때 용이할거 같다
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
