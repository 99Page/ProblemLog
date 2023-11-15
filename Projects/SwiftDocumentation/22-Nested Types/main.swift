//
//  main.swift
//  Nested Types
//
//  Created by wooyoung on 2023/08/22.
//

import Foundation

//  MARK: Nested types

//  다른 타입 내부에 타입 생성하기.
//  중첩의 수에 제한은 없다

//  MARK: Nested types in action

struct BlackjackCard {
    
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
          case two = 2, three, four, five, six, seven, eight, nine, ten
          case jack, queen, king, ace
        
          struct Values {
              let first: Int, second: Int?
          }
        
          var values: Values {
              switch self {
              case .ace:
                  return Values(first: 1, second: 11)
              case .jack, .queen, .king:
                  return Values(first: 10, second: nil)
              default:
                  return Values(first: self.rawValue, second: nil)
              }
          }
      }
    
    let rank: Rank, suit: Suit
    
    var description: String {
       var output = "suit is \(suit.rawValue),"
       output += " value is \(rank.values.first)"
       if let second = rank.values.second {
           output += " or \(second)"
       }
       return output
    }
}

//  MARK: Referring to Nested types

/*
 중첩 타입에 접근하기.
 */

let heartSymbol = BlackjackCard.Suit.hearts.rawValue
print("refer: \(heartSymbol)")
