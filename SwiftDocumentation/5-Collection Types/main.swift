//
//  main.swift
//  Collection Types
//
//  Created by wooyoung on 2023/08/18.
//

import Foundation

/*
 Collection type은 세가지가 있다.
 array: 순서
 set: 순서 없고 유니크
 dictionary: 순서 없고 키밸류
 */

//  MARK: Mutability of Collection

/*
 var로 선언한 Collection에 넣은 값은 바꿀 수 있다. (mutable)
 constant Collection은 값을 바꿀 수 없다. (immutable)
 
 변경되지 않은 경우에만 constant collection 만들자.
 */

//  MARK: Array

// 같은 타입의 값을 순서대로 넣는다.
// Swift Array는 Foundation의 NSArray와 브릿지 되어있다.

//  MARK: Creating an empty array
var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)
someInts = []

//  MARK: Creating an array with a default value
var threeDoubles = Array(repeating: 0.0, count: 3)
var anotherThreeDobles = Array(repeating: 2.5, count: 3)

var sixDouble = threeDoubles + anotherThreeDobles

//  MARK: Creating an array with an array literal
var shoppingList: [String] = ["Eggs", "Milk"]
//  shoppingList: Array<String>
//  배열은 제너릭이다

//  MARK: Accessing and modifying an array

print("The shopping list contains \(shoppingList.count) items")

if shoppingList.isEmpty {
    print("The shopping list is empty")
}

shoppingList.append("Flour")
shoppingList += ["Backing powder"]
shoppingList += ["Chocolate spread", "Cheese", "Butter"]

//  subscript syntax로 배열 값에 접근할 수 있다.
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"

//  index는 유효한 값을 사용해야한다.

//  range를 이용해 여러 값을 바꿀 수 있다
//  아래의 처음 유효한 범위는 5였지만 새로운 값을 넣어서 6까지 접근한다.
shoppingList[4...6] = ["Bananas", "Apples"]

//  아래는 오류가 발생한다.
//shoppingList[7] = "Grape"
print(shoppingList)

shoppingList.insert("Maple syrup", at: 0)

/*
 Array 범위 밖의 인덱스에 접근하면 런타임 에러가 발생한다.
 index가 유효한지 확인해주자.
 유효한 값은 count - 1 까지다.
 */

//  MARK: Iterating over an array

//  배열의 값에 순차적으로 접근한다
for item in shoppingList {
    print(item)
}

//  Index와 Value에 접근한다.
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

//  MARK: Sets

// 순서 없이 값을 저장한다.
// 값을 유일하다.
// 스위프트의 Set은 Foundation의 NSSet과 브릿지되어 있다.

//  MARK: Hash values for Set types

//  Set에 저장되기 위한 키 값은 Hashable 프로토콜을 준수해야한다.
//  a == b -> a 해시값 == b 해시값

//  MARK: Set type syntax

//  Set 선언 방법: Set<Element>
//  배열과는 다르게 equivalent shortand form은 없다.

//  MARK: Creating and initializing an empty set
var letters = Set<Character>()

letters.insert("a")
letters = []

//  MARK: Creating a set with array literal
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

//  Set은 타입 추론 불가능하다. 타입 작성안하면 배열로 처리된다.

//  MARK: Accessing and modifying a set

print("I have \(favoriteGenres.count) favorite music genres.")

favoriteGenres.insert("Jazz")

//  remove는 해당 타입을 옵셔널로 반환한다. 단순 제거만 하지 않는다.
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I`m over it")
}

if favoriteGenres.contains("Fuck") {
    print("I get up on the good foot.")
}

//  MARK: Iterating over a set

for genre in favoriteGenres {
    print("\(genre)")
}

//  Set을 순서대로 접근하고 싶으면 sorted()를 호출
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

//  MARK: Performing set operations

//  두가지 set을 사용해서 집합 연산을 할 수 있다.

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

let _ = oddDigits.union(evenDigits).sorted()
let _ = oddDigits.intersection(evenDigits).sorted()
let _ = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
let _ = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

//  MARK: Set membership and equality

//  ==: 두 Set이 모두 동일한 값을 갖고 있는가
//  isSubset: 값의 일부를 갖고 있음
//  isSuperset: 값을 모두 갖고 있음
//  isStrictSubject / isStrictSuperset: 일부 값만 공유
//  disjoint: 공유하는 값이 전혀 없음

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]


let _ = houseAnimals.isSubset(of: farmAnimals)
// true
let _ = farmAnimals.isSuperset(of: houseAnimals)
// true
let _ = farmAnimals.isDisjoint(with: cityAnimals)
// true

//  MARK: Dictionaries

/*
 값을 key-value로 저장한다. 순서가 없다.
 key는 hashable.
 스위프트의 dictionary는 Foundation의 NSDictionary와 브릿지 되어있다.
 */

//  MARK: Dictionary type shorthand syntax

//  Dictioarny<Key, Value> -> [Key: Value]

//  MARK: Creating an empty dictionary

var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

//  MARK: Creating a dictionary with a dictionary literal

var airports: [String: String] = ["YYZ": "Toronto Pearson",
                                  "DUB": "Dublin"]

//  배열처럼 타입을 명시하지 않아도 된다.
//  타입 명시해야하는 건 Set뿐이다
airports = ["YYZ": "Toronto Pearson",
            "DUB": "Dublin"]

//  MARK: Accessing and modifying a dictionary

//  새로운 값 추가하기
airports["LHR"] = "London"

//  변경하기
airports["LHR"] = "London Heathrow"

//  updateValue는 이전 값을 반환한다
let oldValue = airports.updateValue("LHR", forKey: "LHR")

//  값을 조회할 때는 그 값이 nil일수도 있다.
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName)")
}

//  nil을 넣어서 값을 제거한다.
airports["APL"] = "Apple International"
airports["APL"] = nil

//  removeValue로 값 제거가 가능하다. 마찬가지로 이전 값을 반환해준다.
if let removeValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport`s name is \(removeValue).")
}

//  MARK: Iterating over a dictionary

//  for-in loop으로 key, value를 조회한다

for (airportCode, airpotyName) in airports {
    print("\(airportCode): \(airpotyName)")
}

//  Key값, Value값만 조회도 가능하다.
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ


for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson

//  Key, Value를 배열로 만들 수 있다.
let airportCodes = [String](airports.keys)
// airportCodes is ["LHR", "YYZ"]


let airportNames = [String](airports.values)
// airportNames is ["London Heathrow", "Toronto Pearson"]
