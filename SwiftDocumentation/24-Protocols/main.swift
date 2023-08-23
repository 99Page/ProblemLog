//
//  main.swift
//  Protocols
//
//  Created by wooyoung on 2023/08/23.
//

import Foundation

//  MARK: Protocols

/*
 프로토콜은 메소드, 프로퍼티에 대한 청사진을 제공한다.
 */

//  MARK: Protocol syntax

protocol SomeProtocol {
    
}

struct SomeStructure: SomeProtocol {
    
}

//  conform 순서는 클래스-프로토콜

class SuperClass {
    
}

class SubClass: SuperClass, SomeProtocol {
    
}

//  MARK: Property requirements

/*
 프로토콜의 프로퍼티는 computed/stored를 구분하지 않고
 gettable/settable로 구분한다
 
 프로토콜에 선언된 프로퍼티의 prefix는 var로 고정
 */

protocol PropertyProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

//  MARK: Method requirements

/*
 구현부 없이 명세만 작성.
 default parameter는 사용 불가
 
 static method, class method 사용 가능
 class method는 오버라이딩 불가능
 */

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentailGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        
        return lastRandom / m
    }
}

//  MARK: Mutating method requirements

/*
 value 타입에서 프로퍼티 값을 바꿔야할 때는 프로토콜에도 mutating 선언해줘야한다.
 단, class 타입은 이 keyword 없어도 된다. (class를 작성할 때)
 */

protocol Togglable {
    mutating func toggle()
}

protocol ClassTogglable {
    func classToggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    
    //  value 타입에는 mutating 필요
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

class ClassToggle: Togglable, ClassTogglable {
    var value: Bool = false
    
    //  mutating 없어도 된다
    func toggle() {
        value.toggle()
    }
    
    func classToggle() {
        //  protocol에 mutating 선언 안됐지만 클래스라 가능
        value.toggle()
    }
}

//  MARK: Initializer requirements

protocol InitProtocol {
    init(someParameter: Int)
}

//  MARK: Class implementations of protocol initializer requirements

class InitSuperClass: InitProtocol {
    
    //  class에서 protocol의 init은 designated/convenience 모두 가능
    //  두개 모두 required라고 표시 
    required init(someParameter: Int) {
        
    }
}

//  super class에서 init 상속받고
//  프로토콜에서도 init이 정의되면
//  required override라고 선언
//  단 init이 parameter가 없어야한다

protocol DefaultInitProtocol {
    init()
}

class DefaultInitSuperClass {
    init() {
        
    }
}


class DefaultInitSubClass: DefaultInitSuperClass, DefaultInitProtocol {
    required override init() {
    }
}

//  MARK: Protocol as types

/*
 프로토콜 자체로는 기능을 수행할 수 없지만 코드에서 타입으로 사용할 수는 있다.
 (의존성 주입 / 스트레이트지 패턴처럼)
 
 사용 예제
 - 제너릭
 - opaque type
 - boxec protocol
 
 셋다 추후 다른 문서에서 설명
 */

//  MARK: Delegation

/*
 기능의 실행을 다른 클래스에 위임하는 디자인 패턴.
 외부 데이터 소스(다른 타입의 정보)를 이용할 때 유용
 */

struct Dice {
    func roll() -> Int {
        return 5
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

/*
 순환 참조 방지를 위해 delegate는 weak 레퍼런스를 갖는다.
 */

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice()
    var square = 0
    var board: [Int]
    
    weak var delegate: DiceGameDelegate?
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09;
        board[10] = +02; board[14] = -10; board[19] = -11;
        board[22] = -02; board[24] = -08
    }
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//  MARK: Adding protocol conformance with an extension

/*
 기존 타입의 extension에 프로토콜 추가해서 메소드, 프로퍼티 추가 가능
 
 extension에는 stored 불가능
 */

protocol TextRepresentable {
    var textualDescription: String { get }
}

//  extension에 프로토콜 추가
extension Dice: TextRepresentable {
    var textualDescription: String {
        "Dice text"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        "A game of sankes and ladders"
    }
}

//  MARK: Conditionally conforming to a protcol

//  제너릭 타입에서 제한을 두고 싶을 때 where + 프로토콜 사용하기

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

//  MARK: Declaring protocol adoption with an extension

//  type이 프로토콜의 기능을 작성한 상태에서 protocol을 준수하고 있지 않으면
//  extension으로 따로 뽑을 수 있다

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

//  MARK: Adopting a protocol using a synthesized implementation

/*
 스위프트는 Equatable, Hashable, Comparable의 기능을 자동으로 제공해서 반복적인 코드를 제거해준다.
 
 Equtable은 아래 3가지 경우에 기본 제공
 - structure
 - enum with associated type
 - enum without associated type
 */

/*
 Hashable의 기본 제공
 
 - stored property만 있는 structrue
 - enum with associated type
 - enum without associated type
 */

//  MARK: Collections of protocol types

let hamster = Hamster(name: "hamzzi")
let dice = Dice()

//  타입은 다르지만 프로토콜은 동일하다. 이 경우 프로토콜에 정의된 기능만 접근할 수 있다.
let things: [TextRepresentable] = [dice, hamster]

//  MARK: protocol inheritance

//  프로토콜은 상속 가능하다

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

//  MARK: Class-only protocols

//  AnyObjecy 프로토콜을 채택할 타입을 클래스로 제한

protocol SomeClassOnlyProtocol: AnyObject {
    
}

//  MARK: Protocol composition

/*
 여러 프로토콜을 조합하면 유용하다.
 local에서 임의로 사용할 때 좋다. (함수의 패러미터처럼)
 */

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct NewPerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    
}

let birthdayPerson = NewPerson(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

//  MARK: Checking for protocol conformance

/*
 Type casting에 사용했던 is, as를 프로토콜에도 사용할 수 있다.
 
 is: 프로토콜 채택 유무에 따라 true, false 반환
 as: 프로토콜을 따르고 있으면 해당 프로토콜 타입으로 변환.
 */

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//  as로 타입이 바뀌는 것은 아니다.
//  기본 타입은 그대로 유지되며
//  접근 가능한 범위만 HasArea로 제한된다

//  MARK: Optional protocol requirements

/*
 프로토콜의 내부를 전부 옵셔널하게 만든다.
 */

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Count {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//  MARK: Protocol extensions
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentailGenerator()
print("random number: \(generator.random())")
print("random bool: \(generator.randomBool())")

/*
 extension에만 작성된 기능은 채택된 타입에서 반드시 extension에 정의된대로 동작한다.
 */

//  이 경우 채택 타입에서 반드시 기능을 정의한다.
protocol AbstractMethod {
    func asbstactMethod()
}

//  이 경우 기본적으로는 Extension 기능이 실행되고
//  필요에 따라 타입에서 정의할 수 있다.
protocol HookMethod {
    func hookMethod()
}

extension HookMethod {
    func hookMethod() {
        
    }
}

//  이 경우 반드시 extension 기능이 실행된다.
//  채택된 타입에서 기능을 정의해도 extension이 실행되니 조심해야한다.
protocol DefaultMethod {
    
}
extension DefaultMethod {
    func defaultMethod() {
        
    }
}

//  MARK: Providing default implementations

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//  MARK: Adding constraints to protocol extensions

//  protocol에 제한 두기
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
            for element in self {
                if element != self.first {
                    return false
                }
            }
            return true
        }
}
