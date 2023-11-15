//
//  main.swift
//  Type Casting
//
//  Created by wooyoung on 2023/08/22.
//

import Foundation

//  MARK: Type Casting

/*
 is
 as
 */

//  MARK: Defining a class hierarchy for type casting

//  base class
class MediaItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}


class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

//  library 타입은 [MediaItem]으로 추론된다
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//  MARK: Checking type

/*
 class Type을 확인할 때는 is 사용
 */

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//  MARK: Downcasting

//  as? as! 사용
//  as? 는 실패할 경우 nil 반환

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir: \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

//  MARK: Type casting for Any and AnyObject

/*
 Any: 모든 인스턴스 유형
 AnyObject: any class type
 */

var things: [Any] = []

//  Any 배열에 모든 타입을 넣고 있다. optional도 가능
//  그런데 optional은 Any로 사용될 때 as로 명시해줘야 한다.
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
