//
//  main.swift
//  Optional Chainig
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

//  MARK: Optional chaining as an alternative to forced unwrapping

class Person {
    var residence: Residence?
}


class Residence {
    var numberOfRooms = 1
}

let john = Person()

//  !를 이용한 강제 언래핑
//  런타임에러가 발생할 수도 있다
let roomCount = john.residence!.numberOfRooms

//  chain 방식
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

//  MARK: Accessing Properties Through Optional Chaining



