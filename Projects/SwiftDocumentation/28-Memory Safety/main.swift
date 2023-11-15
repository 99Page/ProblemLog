//
//  main.swift
//  Memory Safety
//
//  Created by wooyoung on 2023/08/25.
//

import Foundation

//  MARK: Memory safety

/*
 스위프트의 메모리 안정성
 - 사용되기 전에 초기화 되어야 한다
 - 해제된 메모리에 접근 할 수 없다
 - 배열의 인덱스는 out-of-bounds 검사를 해야된다
 
 같은 메모리 공간에 동시에 접근해서 컨플릭트 발생하지 않도록 돕는다.
 하지만 컨플릭트가 발생할 상황은 알아두자
 */

//  MARK: Understanding conflicting access to memory

/*
 프로퍼티에 값을 세팅할 때
 함수의 argument를 전달할 때
 메모리에 접근한다
 */

// set을 통한 메모리 접근
var one = 1

// read를 통한 메모리 접근
print("We`re number \(one)!")

/*
 다른 코드에서 같은 메모리에 접근할 때 컨플릭트 발생.
 
 이곳에서 말하는 컨플릭트는 싱글 스레드의 상황을 말한다.
 */

//  MARK: Characteristics of memory access

/*
 컨플릭트가 발생하는 상황
 아래 조건 중 두개를 만족하면 컨플릭트 발생
 
 - 접근 중 하나는 write거나 nonatomic
 - 같은 메모리에 접근
 - 시간이 겹침(overlap)
 */



//  MARK: Conflicting access to in-out parameters

var stepSize = 1

//  inout은 long-term write access
//  일반적인 set같은 경우 set하고 바로 끝나지만
//  inout은 함수가 끝날 때까지 set에 접근이 가능하다


func increment(_ number: inout Int) {
    
    //  number는 stepSize에 접근하고(write)
    //  stepSize는 stepSize에 접근한다.(read)
    //  메모리 접근의 overlap 발생
    number += stepSize
}

// 빌드 시 에러 발생
//increment(&stepSize)

//  해결 방법1. stepSize copy
var copyOfStepSize = stepSize
increment(&copyOfStepSize)
stepSize = copyOfStepSize

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore) // 문제없음

// access conflict
//balance(&playerOneScore, &playerOneScore)

//  MARK: Conflicting access to self in methods

/*
 structure의 mutating method는 self에 write access를 갖는다.
 */

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)

//  oscar에 대한 접근, maria에 대한 접근이 따로
oscar.shareHealth(with: &maria)

//  oscar에 대한 write access 두번으로 에러
//oscar.shareHealth(with: &oscar)

//  MARK: Conflicting access to properties

/*
 mutating은 해당 프로퍼티가 아니라 전체 프로퍼티에 대한 접근을 갖는다.
 */

var playerInformation = (health: 10, energy: 20)

//  health, energy에 대한 write access는 별로가 아니라서 에러
//balance(&playerInformation.health, &playerInformation.energy)


//  local value는 OK
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy) // 얘는 가능
}

/*
 아래 조건을 만족하면 memory safe
 
 computed property나 class property가 아닌 stored property에 대한 접근
 local 변수
 struct가 capture되지 않음. 혹은 nonescpaing에만 capture됨 
 */
