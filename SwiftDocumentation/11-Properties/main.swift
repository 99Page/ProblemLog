//
//  main.swift
//  Properties
//
//  Created by 노우영 on 2023/08/20.
//

import Foundation

//  MARK: Properties

/*
 stored properties: 저장되는 값. enum에 ㅏㅅ용 불가
 computed properties: stored 프로퍼티를 계산한 프로퍼티.
 type propreties: 타입 그 자체에 관련된 값
 
 프로퍼티 래퍼를 사용해 getter setter 재사용 가능
 */

//  MARK: Stored properties

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

// 멤버와이즈 이니셜라이저를 사용한 초기화
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//  let은 변경 불가능
//  rangeOfThreeItems.length = 3

//  MARK: Lazy stored properties

//  사용되기 전까지 계산되지 않은 프로퍼티
//  var 에만 사용 가능
//  let은 초기화 전에 값을 가져야한다.
//  lazy는 초기화 후에도 값을 갖는다

class DataImporter {
    var filename = "data.txt"
}

/*
 DataImporter는 데이터를 접근하는 역할을 하는데
 꼭 이 클래스를 이용하지 않을 수도 있다.
 이런 경우에 lazy 사용한다.
 
 */
class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}


let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//  이 시점까지는 importer가 생성되지 않는다.

print(manager.importer.filename) //사용될 때 생성된다.

//  멀티쓰레드 환경에서 동시에 접근될 경우에 한번 생성될거란 보장이 없다.

//  MARK: Stored properties and instance variables

//  MARK: Computed properties

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

//  computed property는 다른 값에 getter setter를 제공한다
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//  MARK: Shorthand declaration

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        //  setter의 값을 정해주지 않으면 newValue로 접근할 수 있다
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            //  코드가 한줄이면 return 생략 가능
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//  MARK: Read-Only Computed Properties

//  setter 없는 computed property
//  var로 선언해야한다.

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

//  MARK: Property observers

/*
 프로퍼티 값의 변경에 응답.
변경된 값이 기존과 동일해도 응답
 
 stored property
 상속받은 stored property
 computed property
 
 세곳에 사용 가능
 */
  
/*
 상속받은 곳에서 사용될 경우
 상위의 옵저버가 먼저 실행되고 하위의 옵저버가 다음에 실행된다
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360

//  옵저버가 있는 프로퍼티를 inout으로 parameter에 사용하면 항상 willset didset이 호출된다.
//  copy-in copy-out 메모리 모델때문에 그렇다.

//  MARK: Property wrappers

//  프로퍼티 래퍼에서 접근 가능한건 wrappedValue
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    //  프로퍼티 래퍼와 같은 타입일 경우 사용할 수 있다
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

struct SmallRectangleUnderScore {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

//  MARK: Setting Initial Values for Wrapped Properties

/*
 프로퍼티가 저장될 방법을 분리하고 싶을 때 사용할 수 있다.
 간단히 computed proeperty 재사용하고 싶을 때 쓰면 될거같다
 */
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int


    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    // 프로퍼티 래퍼에 초기화 주는 방법
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()

// 다양하게 초기값 주기
// 나는 width 방식으로 쓰는게 좋아보인다
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    var width = SmallNumber(wrappedValue: 3)
}

//  MARK: Projecting a value from a property wrapper

/*
 프로퍼티 래퍼는 projected value를 정의할 수 있다.
 프로퍼티 래퍼가 다루는 값에 추가적인 정보를 하나 더 주고 싶을 때 사용한다
 */

@propertyWrapper
struct SmallNumberWithProjectedValue {
    private var number: Int
    private(set) var projectedValue: Bool


    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }


    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @SmallNumberWithProjectedValue var someNumber: Int
}
var someStructure = SomeStructure()
 
someStructure.someNumber = 4
print(someStructure.$someNumber)

//  MARK: Global and Local Variables

/*
 타입없이 선언된 변수
 computed property, observer 정의 가능
 global 값들은 lazy하게 동작한다.
 */

/*
 local에는 프로퍼티 래퍼 적용 가능
 global에는 불가능
 */

//  MARK: Type property

/*
type property = static
 
 lazy하게 적용하지만
 한번 생성되는것이 보장된다
 */

//  MARK: Type property syntax

struct SomeStructureWithTypeProperty {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    
    //  currentLevel이 if문 내에서 재호출 되지만
    //  observer가 재호출되지는 않는다
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
