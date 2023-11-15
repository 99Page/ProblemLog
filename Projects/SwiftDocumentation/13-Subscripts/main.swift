//
//  main.swift
//  Subscripts
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

//  MARK: Subscripts

/*
 collection에 접근하는 shortcut
 
 ex)
 array[index]
 dictionay[key]
 
 index와 key가 subscript
 */

//  MARK: Subscript syntax

/*
 문법은 computed property와 유사하다.
 패러미터를 이용한다
 */

struct TimesTable {
    let multiplier: Int
    
    //  readonly. collection 없이 사용한 예제
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

//  MARK: Subscript usage

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//  MARK: Subscript options

/*
 여러개를 parameter로 이용할 수 있다.
 inout빼고는 다된다
 */

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

//  MARK: Type subscripts

//  타입 프로퍼티처럼 타입 스크립트도 존재한다
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
