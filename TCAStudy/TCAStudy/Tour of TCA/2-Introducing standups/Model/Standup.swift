//
//  Standup.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import Foundation

struct Standup: Equatable, Identifiable, Codable {
    var id: String = UUID().uuidString
  var attendees: [Attendee] = []
  var duration = Duration.seconds(60 * 5)
  var meetings: [Meeting] = []
  var theme: Theme
    var title: String

  var durationPerAttendee: Duration {
    self.duration / self.attendees.count
  }
}

extension Standup {
    
    //  id를 랜덤하게 만들어주기 위해 프로퍼티보다는 메소드 사용이 좋음
    static func mock() -> Self {
        Self(theme: .allCases.randomElement()!,
             title: "Daily scrum")
    }
}
