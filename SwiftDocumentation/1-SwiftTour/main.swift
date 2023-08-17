//
//  main.swift
//  SwiftDocumentation
//
//  Created by wooyoung on 2023/08/17.
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour
import Foundation

print("Hello, world!")

//  MARK: Simple value

var myVariable = 42
 myVariable = 50

// 타입을 명시하지 않았지만 컴파일러가 추론한다.
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 7.0
let explicitDouble: Double = 70

let constantExplicitFloat: Float = 4

let label = "The width is"
let width = 94

// 다른 타입으로 변환하고 싶으면 반드시 명시적으로 타입을 작성해준다.
let widthLabel = label + String(width)

//  \()를 사용해서 다른 타입을 String으로 바꿀 수 있다.

let apples = 3
let appleSummary = "I have \(apples) apples."

//  """를 사용해 문자열을 여러줄로 만든다.
let quotation = """
                Enven thouth there`s whitespace to the left,
                the actual lines aren`t indented
                    expect for this line.
                Double quotes (") can appear with out being escaped.
                
                I still have \(apples) pieces of apple.
                """

var fruits = ["strawberries", "limes", "tangerines"]
  fruits[1] = "grapes"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic"
]

occupations["Jayne"] = "Public Relations"

fruits.append("blueberries")
fruits = []
occupations = [:]

let emptyArray: [String] = []
let emptyDictionary: [String: Float] = [:]

//  MARK: Control Flow

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore) // Prints "11"

var optionalString: String? = "Hello"
print(optionalString == nil) // Prints "false"

var optionalName: String? = "Jone Appleseed"
var greeting = "Hello"

if let name = optionalName {
    greeting = "Hello, \(name)"
}

let nickname: String? = nil
let fullname: String = "Jone Appleseed"
let informalGreeting = "Hi \(nickname ?? fullname)"

if let nickname {
    print("Hey, \(nickname)")
}

let vegetable = "red pepper"

//  각 case 이후에 break 작성하지 않아도 된다.
switch vegetable {
case "celery":
    print("Add some raisins and mke ants on a log.")
    
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
    
//  pattern을 이용할 수 있다.
case let x where x.hasPrefix("pepper"):
    print("Is it a spicy \(x)?")
    
default:
    print("Everything tastes good in soup")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25]
]

var largest = 0

//  Key, value를 이용해 Dictionary를 순회한다.
//  Dictionary는 순서가 없기때문에 무작위로 순회한다.
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}

var n = 2
while n < 10 {
    n *= 2
}

//  repeat을 사용할 경우 loop가 최소 한번은 실행된다.
var m = 2
repeat {
    m *= 2
} while m < 100
            
//  MARK: Functions and closures

//  함수의 레이블이 사용된 형태
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

let _ = greet(person: "Bob", day: "Tuesday")

//  _를 사용할 경우 argument는 없다.
//  parameter 앞에 argument를 커스텀할 수 있다.
func customLabelGreet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
let _ = customLabelGreet("Bob", on: "Tuesday")


func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in individualScores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

//  함수는 중첩가능하다.
//  Inner 함수는 Outer 함수의 변수에 접근할 수 있다.
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

/**
 함수는 first-class type으로 반환값이 될 수 있고
 argument가 될 수 있다.
 */
func makeIncrementer() -> ((Int) -> (Int)) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

//  closure 형식으로 함수를 전달할 수 있다.
numbers.map { number in
    let result = 3 * number
    return result
}

//  parameter를 이름이 아닌 숫자로 접근할 수 있다.
let sortedNumbers = numbers.sorted { $0 > $1 }

//  MARK: Objects and classes

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//  dot 연산자(.)를 사용해 클래스의 프로퍼티와 함수에 접근할 수 있다.
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//  모든 프로퍼티는 값이 할당되어야 한다. 선언되어 있어도 되고 이니셜라이저 내부여도 된다.
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    //  프로퍼티의 이름과 argument의 이름을 구분하기 위해 self를 사용한다.
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    //  상위 클래스에서 정의된 함수는 반드시 override로 명시되어야 한다.
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)/"
    }
}

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    //  computed property를 활용해 프로퍼티에 getter setter를 추가할 수 있다.
    var perimeter: Double {
        get { return 3.0 * sideLength }
        
        //  새로운 값은 newValue라는 implicit name을 갖는다.
        set { sideLength = newValue / 3.0 }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of lenght \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter = 9.9

class TriangleAndSqure {
    
    /**
     Computed property를 활용한 getter/setters는 필요없지만 값의 세팅 앞뒤로
     코드를 실행하고 싶으면 WillSet, didSet을 활용할 수 있다.
     이 둘은 init을 제외하고 값이 바뀔떄마다 실행된다.
     */
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

//  MARK: Enumarations and Structures

/**
 값을 나열하기 위해 열거형을 만들 수 있다. 클래스같은 name type처럼 메소드와 관련된 값을 정의한다.
 */
enum Rank: Int {
    
    //  스위프트는 enum의 raw value를 0부터 시작해서 1씩 증가시킨다.
    //  여기서는 1부터 시작하도록 명시해서 시작값이 1이 된다.
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

//  rawValue를 사용해 초기화할 수 있다. 이 경우 nil이 반환될 수 있다.
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

//  enum에 raw 값은 없어도 된다.
enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        //  함수 내부에서는 self과 Suit type이라는 것을 알고 있기때문에
        //  dot 연산자로 case에 접근할 수 있다.
        switch self {
        case .spades:
            return "spaced"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

//  rawValue 대신 각 케이스마다 associatedValue를 사용할 수 있다.
//  이 값은 각 케이스가 인스턴스화할때 갖는 storedValue라고 생각하면 된다.
enum ServerReponse {
    case result(String, String)
    case failure(String)
}

let success = ServerReponse.result("6:00 am", "8:09 pm")
let failure = ServerReponse.failure("Out of cheese.")

switch success {
    
    //  인스턴스를 만들 때 넣어준 associatedValue를 추출하는 방식에 주목하자.
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure... \(message)")
}

/**
 class와 struct는 큰 차이는 없고 사용 될 때 copy의 대상이 value/reference 정도가 다르다.
 */
struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

//  MARK: Concurrency

//  비동기 함수 선언시 async를 사용한다.
func fetchUserID(form server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

//  await 키워드를 사용해서 비동기 함수를 호출한다.
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(form: server)
    if userID == 501 {
        return "John Appleseed"
    }
    
    return "Guest"
}

func connectUser(to server: String) async {
    //  비동기 함수를 병렬적으로 처리하고 싶을 때 async let을 사용하고
    async let userID = fetchUserID(form: server)
    async let userName = fetchUsername(from: server)
    
    //  병렬처리 된 함수를 결국 호출할 때 await을 다시 사용해준다.
    let greeting = await "Heloo \(userName), userID \(userID)"
    print(greeting)
}

//  동기 코드에서 비동기 함수를 실행하고 싶으면 Task를 사용해준다.
Task {
    await connectUser(to: "primary")
}

//  MARK: Protocols and Extensions

protocol ExampleProtocol {
    var simpleDescription: String { get }
    
    //  내부 프로퍼티 값을 바꾸고, struct에서 사용되는 메소드는
    //  mutating을 선언해준다. class에는 필요없다.
    mutating func adjust()
}

//  class, enum, struct는 프로토콜의 기능을 준수할 수 있다.
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    
    func adjust() {
        simpleDescription += "Now 100% adjusted"
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//  기존에 존재하는 타입에 함수나 computed property를 추가하고 싶을 때
//  extension을 사용해준다. stored property는 저장할 수 없다.
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}

//  런타임에는 변수가 SimpleClass라는 것을 알 수 있지만 컴파일러는 모른다.
//  이런 경우 프로토콜에 접근할 수 없다.
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)

//  MARK: Error handling

//  아무 타입에 Error 프로토콜을 사용해서 에러를 표현한다.
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPriter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    
    return "Job sent"
}

//  do-catch 문을 이용해 에러를 처리할 수 있다.
do {
    let printerResponse = try send(job: 1040, toPriter: "Bi sheng")
    print(printerResponse)
} catch {
    print(error)
}

//  처리하고 싶은 에러의 패턴을 지정해서 각 에러 케이스마다 다르게 처리할 수 있다.
do {
    let printerResponse = try send(job: 1440, toPriter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I`ll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError)")
} catch {
    print(error)
}

//  try? 를 사용해 에러를 처리하는 경우, error가 반환됐을 때 nil처리 된다.
let printerSuccess = try? send(job: 1884, toPriter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPriter: "Never Has Toner")

var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

//  함수의 모든 코드가 실행된 후에 defer가 실행된다.
//  error와 상관 없이 항상 실행된다.
func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

//  MARK: Generics

func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result: [Item] = []
    
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    
    return result
}

makeArray(repeating: "knock", numberOfTimes: 4)

enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)

/*
 body 이전에 where문을 사용해서 제너릭 타입이 따라야할 프로토콜/클래스를 지정할 수 있다.
 <T: Equatable>과 <T> ... where T: Equatable을 동일하다. 
 */
func anyCommentElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
    
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    
    return false
}

anyCommentElements([1, 2, 3], [3])
