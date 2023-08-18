//
//  main.swift
//  Strings and Characters
//
//  Created by wooyoung on 2023/08/18.
//

import Foundation

/*
 String은 다양한 방법으로 사용된다.
 ex) Character의 콜렉션
 
 String은 NSString 클래스와 연결되어 있다.
 */

//  MARK: String literals

let someString = "Some string literal value"

//  MARK: Multiline string literals

/*
 multiline string은 """ 내부의 모든 라인을 포함한다.
 */
let quotation = """
The whire rabbit put on his spectalces. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; the stop."
"""

// 아래 두 String은 동일하다
let singleLineString = "These are the same."
let multilineString = """
There are the same.
"""

let softWrappedQuotation = """
The white rabbit put on his spectacles. "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; the stop."
"""

//  첫번째와 마지막 줄은 공백을 포함하지 않는다.
let linesWithIndentation = """
    This line doesnt` begin with white space.
        This line begins with four spaces.
    This line doesn`t begin with whitespace.
    """
// 마지막 줄의 """의 공백이 기준이다.

print(linesWithIndentation)


//  MARK: Special Characters in String literals

/*
 \0: Null
 \\: backslash
 \t: horizontal  tab
 \n: line feed
 \r: carriage return
 \": double quotation mark
 \': single quotation mark
 \u{n}:
 */

//  캐릭터를 escape 시켜야 "를 사용할 수 있다.
let wiseWords = "\"Imagenation is more importatnt than knowledge\" - Einstein"

let dollarSign = "\u{24}" // $. 유니코드 24.
let blackHeart = "\u{2665}" // ♥
let sparklingHeart = "\u{1F496}" // 💖

print(dollarSign)
print(blackHeart)
print(sparklingHeart)

let threeDoubleQuotationMarks = """
Escaping the first quotation mars \"""
Escaping all three quotation marks \"\"\"
"""

//  MARK: Extened String delimiters

//  #를 이용하면 String 내부에서 escacping 없이 특수 캐릭터를 이용할 수 있다.
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

//  MARK: Initializing an empty String

//  아래 두개는 동일하다
var emptyString = ""
var anotherEmptyString = String()

//  MARK: String mutability

var variableString = "Horse"
variableString += " and carriage"

let constatneString = "Highlander"
//constatneString += " and another Highlander"

//  MARK: String are value type

/*
 스위프트의 String은 value type이다.
 */


//  MARK: Working with Characters

for character in "Dog!" {
    print(character)
}
/*
 D
 o
 g
 !
 */

let exclamationMark: Character = "!"

//  Character 배열로 String 만들기
let catCharacters: [Character] = ["C", "a", "t"]
let catString = String(catCharacters)

//  MARK: Concatenationg String and Characters

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

//  Character도 추가할 수 있다.
welcome.append(exclamationMark)

let badStart = """
    one
    two
    """

let end = """
    three
    """

print(badStart + end)
/*
 one
 twothree
 */

let goodStart = """
    one
    two
    
    """
print(goodStart + end)
/*
 one
 two
 three
 */

//  MARK: String interpolation

// String interpolation을 사용해 여러 값을 조합한 새로운 문자열을 만든다.

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//  Delimeter를 쓰는 경우 String interpolation을 사용할 수 없다.
let delimiterString = #"Write an inpterpolated string in Swift using \(multiplier)"#
print(delimiterString)

//  Delimeter와 String interpolation 함께 사용하기
print(#"6 times 7 is \#(6*7)"#)

//  Interpolation에는 carriage return, line feed 사용 할 수 없다.

//  MARK: Unicode

/*
 운영체제마다 시스템이 다른데,
 유니코드는 텍스트를 인코딩 하기 위한 국제표준.
 */

/*
 스위프트 String은 21비트 유니코드를 사용한다.
 */

//  MARK: Extened grapheme clusters

//  아래 두개는 동일하다.
//  Unicode를 합칠 수 있다.
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
print(eAcute)
print(combinedEAcute)

//  한글 같은 경우 한 글자로 나타내거나 초성/모음/종성으로 나눌 수 있다.
let precomposed: Character = "\u{D55C}" // 한
let decomposed: Character = "\u{1112}\u{1162}\u{11AB}" // ㅎ ㅏ ㄴ

//  MARK: Counting characters

let unusualMenagerie = "Koala, Snail, Penguin, Dromedary"
print("unusualMenagerie has \(unusualMenagerie.count) characters")

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
//  word.count = 4

//  마지막 캐릭터에 합쳐진다.
word += "\u{301}"
print("the number of character in \(word) is \(word.count)")
//  word.count = 4
//  문자의 수는 같지만 사용하는 메모리 양은 달라진다


//  MARK: Accessing and modifying a String

//  subscript 문법을 사용해 String에 접근 및 수정할 수 있다.
//  위에서 말한대로 같은 문자열에은 다른 양의 메모리를 사용해서
//  Int를 인덱스로 사용할 수 없다.

//  String의 첫번째 캐릭터에 접근하고 싶으면 startIndex 프로퍼티를 사용하자.
//  endIndex 프로퍼티는 마지막 문자열의 다른 위치를 가리킨다.
//  즉, endIndex로 캐릭터를 얻을 수 없다.

let greeting = "Guten Tag!"

greeting[greeting.startIndex] // G
greeting[greeting.index(before: greeting.endIndex)] // !
greeting[greeting.index(after: greeting.startIndex)] // u

let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index] // a

//  Collection 프로토콜을 따르는 모든 타입에 index(before:), index(after:) index(_:offsetBy:)를 사용할 수 있다.


//  MARK: Inserting and Removing
welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// hello!

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
//  hello there!

welcome.remove(at: welcome.index(before: welcome.endIndex))
//  hello there

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex

welcome.removeSubrange(range)
// hello

/*
 RangeReplaceableCollection 프로토콜을 따르는 모든 타입에
 insert(_:at:), insert(contensof:at:),
 remove(at:), removeSubrange(_:) 메소드를 사용할 수 있다.
 */

//  MARK: Substring

/*
 Substring은 String과 거의 동일하다.
 그런데 잠깐만 사용해야 한다.
 장기간 사용할거 같으면 String으로 바꿔준다.
 */

let newGreeting = "Hello, world!"
let commaIndex = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<commaIndex]
//  beginning = "Hello" and Substring

//  장기간 쓰려면 String으로 전환
let newString = String(beginning)

//  Substring은 String의 메모리 영역을 공유한다.
//  String이 사용되지 않더라도 Substring이 사용되고 싶으면
//  불필요한 메모리가 계속 유지된다.

//  MARK: Comparing Strings

//  문자열은 Extended grapheme cluster가 동일하면 동일하다.
let newQuotation = "We`re a lot alike, you and I."
let sameQuotation = "We`re a lot alike, you and I."
if newQuotation == sameQuotation {
    print("These two strings are considered equal")
}

let eAcuteQuestion = "\u{E9}"
let combineEAcuteQuestion = "\u{65}\u{301}"

if eAcuteQuestion == combineEAcuteQuestion {
    print("These two strings are considered equal")
}

print("\u{41}") // A
print("\u{0410}") // A
// 위 두개는 다르다

//  MARK: Prefix and Suffix equality

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}

//  1
print("There ar \(act1SceneCount) scenes in Act1")


var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"

//  비교는 extened grapheme clustser를 이용해 character-by-character로 이루어진다.

//  MARK: Unicode representations of Strings

