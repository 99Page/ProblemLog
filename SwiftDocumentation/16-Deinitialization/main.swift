//
//  main.swift
//  Deinitialization
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

//  MARK: Deinitialization

/*
 class가 메모리에서 해제되기 전에 호출된다
 */

//  MARK: How deinitialization works

/*
 스위프트에서는 인스턴스가 더이상 사용되지 않으면 자동으로 메모리에서 해제한다.
 ARC를 이용
 메모리 해제 전에 deinit을 호출해 작업을 어떤 작업을 수행할 수 있고
 이 때 parameter는 사용할 수 없다
 */

//  MARK: Deinitializers in action

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
