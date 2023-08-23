//
//  main.swift
//  Generics
//
//  Created by wooyoung on 2023/08/23.
//

import Foundation

//  MARK: Generics

// 여러 타입에 동작하는 기능

//  MARK: The problem that generics solve


//  아래 세 함수는 기능은 동일한데 타입만 다르다
//  타입에 관련해서 코드의 중복을 줄이고 싶을 때 제너릭을 사용한다.
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings( a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles( a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  MARK: Generic functions

//  제너릭에 placeholder type을 작성한다.
//  이 타입은 어떤 타입이든 될 수 있다
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anthoerInt = 107
swapTwoValues(&someInt, &anthoerInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

//  MARK: Type parameters

//  지정된 placeholder type은 함수 내부에서 같은 이름으로 사용된다.
//  함수의 parameter, 내부의 타입, 반환 타입 모두 다 된다.

//  MARK: Naming type parameters

/*
 placeholder type의 이름은 사용되는 관계를 나타내준다.
 예를 들어서 배열에는 Element,
 딕셔너리에는 Key, Value가 사용된다.
 
 명확한 관계가 없을 때는 T, U, V가 많이 쓰인다.
 타입의 이름은 UpperCamelCase로 작성
 */

//  MARK: Generic types

/*
 함수 말고 타입에도 제너릭 사용가능하다.
 Array, Dictionary도 제너릭을 사용한 타입이다
 */

//  Int에서만 가능한 스택
struct IntStack {
    var items: [Int] = []
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//  모든 타입에 가능한 스택
//  Element type placeholder는 세곳에 사용됐다.
//  프로퍼티 타입 정의
//  패러미터 정의
//  반환값 정의
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

//  MARK: Extending a generic type

//  origin type의 제너릭을 그대로 사용 가능
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//  MARK: Type constraints

/*
 위의 제너릭은 모든 타입에서 사용 가능한데, 특정 타입에 제한을 주고 싶은 경우에 사용.
 사용할 타입이 특정 클래스를 상속하거나 혹은 프로토콜을 준수해야한다.
 
 딕셔너리의 Key는 Hashable을 준수한다.
 */

//  MARK: Type constraint syntax

class SomeClass {
    
}

protocol SomeProtocol {
    
}

func someFunction<T: SomeClass, U: SomeProtocol> (someT: T, someU: U) {
    
}

//  MARK: Type constraints in Action

//  이 함수는 String에만 사용 가능
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

let strings = ["cat", "dog", "llama"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//  아래는 컴파일 되지 않는다.
//  value에 == 연산이 되지 않기때문.
//  == 연산은 Equtable 프로토콜에 있다

//func findIndex<T> (of valueToFind: T, in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//
//    return nil
//}

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14145, 0.1, 0.25])

//  MARK: Associated types

//  protocol에 제너릭처럼 사용하기
//  다른 타입에 채택될 때 타입을 지정한다

//  MARK: Associated types in action

//  Container를 채택한 타입은 Item의 타입을 지정해야한다.
protocol Container {
    
    //  타입은 모르지만 프로토콜 내부에서는 지칭할 수 있어야한다.
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension IntStack: Container {
    var count: Int {
        return items.count
    }
    
    //  Item이 Int 타입이라고 추론해준다
    mutating func append(_ item: Item) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
    typealias Item = Int
}

struct IntStackContainer: Container {
    
    //  이게 없어도 subscript에서 Int 타입을 반환하니
    //  Item이 Int라고 추론한다
    typealias Item = Int
    
    var items: [Int] = []
    
    var count: Int {
        return items.count
    }
    
    //  Item이 Int 타입이라고 추론해준다
    mutating func append(_ item: Item) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

extension Stack: Container {
    mutating func append(_ item: Element) {
           self.push(item)
       }
   var count: Int {
       return items.count
   }
   subscript(i: Int) -> Element {
       return items[i]
   }
    
    typealias Item = Element
    
    
}

//  MARK: extending an existing type to specify an associated type

//  Swift Array는 Container의 기능이 이미 구현되어 있다
extension Array: Container {
    
}

//  MARK: Adding constraints to an associated type


//  메소드처럼 제한을 할 수 있다.
protocol ConstaraintsContainer {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
   var count: Int { get }
   subscript(i: Int) -> Item { get }
}

//  MARK: Using a protocol in its associated type`s constraints

protocol SuffixableContainer: ConstaraintsContainer {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    
    func suffix(_ size: Int) -> Suffix
}

//  MARK: Generic where clauses

//  Container의 Item이 같도록 제약을 주었음
func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    
    if someContainer.count != anotherContainer.count {
        print("count mismatch: \(someContainer.count) \(anotherContainer.count)")
        return false
    }


    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            print("\(someContainer[i]) \(anotherContainer[i])")
            return false
        }
    }


    // All items match, so return true.
    return true
}

var stackOfStrings2 = Stack<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")


var arrayOfStrings = ["uno", "dos", "tres"]

//  아래 함수를 호출하려면 두 스택의 Element가 동일해야한다.
if allItemsMatch(stackOfStrings2, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}

//  MARK: Extensions with a generic where clause

//  Stack에 사용된 Element가 Equatable을 채택한 경우
//  사용 가능한 메소드
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        
        return topItem == item
    }
}

//  프로토콜에도 동일하게 사용한다.
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
           return count >= 1 && self[0] == item
       }
}

//  타입을 지정할 때는 is가 아니라 == 사용
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}



//  MARK: Contextual where clauses

/*
 프로토콜의 특정 메소드에만 제약걸기
 개인적으로는 extension에 하는게 좋아보임
 */

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]

print(numbers.average())
print(numbers.endsWith(37))

let strings3 = ["ABC", "abc"]
// print(strings3.average()) 사용 불가능

//  MARK: Associated types with a generic where clause

protocol GenericWhereContainer {
    associatedtype Item
    mutating func apeend(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

//  하위 프로토콜에서 제약조건 추ㅏㄱ로 걸수 있따
protocol ComaparableContainer: Container where Item: Comparable {
    
}

//  MARK: generic subscripts

protocol SubscriptContainer {
    associatedtype Item
}

//extension SubscriptContainer {
//    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
//        var result: [Item] = []
//                for index in indices {
//                    result.append(self[index])
//                }
//                return result
//    }
//}
