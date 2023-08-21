//
//  main.swift
//  Error Handling
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

//  MARK: Representing and throwing errors

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//  MARK: Handling errors

/*
 에러 처리 방식은 4가지가 있다
 propagate the error
 do-catch
 optional
 assert
 
 throw의 성능은 return과 비슷하다
 다른 언어 처럼 call stack 작업이 없다.
 */

//  MARK: Propagating errors using thorwing functions

//  throw 키워드 사용
//  throw는 호출한 쪽에서 에러 처리
//  나머지는 함수 내부에서 에러 처리

func canThrowErrors() throws -> String {
    return ""
}

func cannotThrowErrors() -> String {
    return ""
}

struct Item {
    var price: Int
    var count: Int
}


class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0


    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }


        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }


        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }


        coinsDeposited -= item.price


        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem


        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

//  MARK: Handling errors using do-catch

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

//  에러 타입 매칭
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    
} catch VendingMachineError.outOfStock {
    
} catch VendingMachineError.insufficientFunds(let coninsNeeded) {
    print("\(coninsNeeded)")
} catch {
    
}

//  is 사용.
func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

//  MARK: Converting erros to optional values

//  try?

func someThrowingFunction() throws -> Int {
    return -1
}

//  x는 Int?가 되고 특별한 에러처리 안해도 된다
//  throws된 경우 x는 nil이 된다
let x = try? someThrowingFunction()

let y: Int?

do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//  MARK: Disable error propagation

//  에러 처리는 하지않고, 에러가 없을거라고 확신하는 경우
//  optional의 !처럼 런타임 에러 가능성이 있다

func loadImage(path: String) throws -> String {
    return ""
}

let photo = try! loadImage(path: "")

//  MARK: Specifying cleanup actions

//  throws 되기 전 실행하기 위해서 defet를 사용할 수 있다.

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
    }
}

func exists(_ fileName: String) -> Bool {
    return true
}

func open(_ fileName: String) -> String {
    return ""
}

func close(_ file: String) {
    
}
