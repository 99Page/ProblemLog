//
//  main.swift
//  KeyPathStudy
//
//  Created by 노우영 on 2023/10/08.
//

import Foundation

/**
 KeyPath와 WritableKeyPath를 파악하기 위한 파일.
 */

/**
 KeyPath: A key path from a specific root type to a specific resulting value type.
 정의만으로는 파악하기가 어렵다.
 */

struct Animal {
    let name: String
    var age: Int = 1
    var hello: String = "hello"
}

var animal = Animal(name: "horse")
print(animal.name)
print(animal[keyPath: \Animal.name]) // dot으로 접근하는 것처럼 keyPath로 프로퍼티에 접근할 수 있다.

print(type(of: \Animal.name)) // KeyPath<Animal, String>, name은 let
print(type(of: \Animal.age)) // WritableKeyPath<Animal, Int>, age는 var

/**
 어떻게 사용할 수 있을까?
 바꾸고 싶은 프로퍼티를 일단 지정해두고 나중에 바꾸고 싶을 때
 */

// Animal의 hello를 바꿀건데 무슨 값으로 바꿀지는 모르고 일단 얘 바꾸는것만 확정시키기
let keyPath = \Animal.hello

// 미리 지정해둔 keyPath값으로 변경하기
animal[keyPath: keyPath] = "horrrrrrrr"
print(animal)


// rebase1
// rebase2 
