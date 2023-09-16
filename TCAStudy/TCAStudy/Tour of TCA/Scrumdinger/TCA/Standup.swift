//
//  Sandup.swift
//  TCAStudy
//
//  Created by 노우영 on 2023/09/16.
//

import Foundation

struct Standup: Equatable, Identifiable, Codable {
    let id: UUID
    var attendees: [Attendee] = []
    var duration = Duration.seconds(60 * 5)
    var meetings: [Meeting] = []
    var theme: Theme = .bubblegum
    var title = ""
}

struct Attendee: Equatable, Identifiable, Codable {
    let id: UUID
    var name = ""
}

struct Meeting: Equatable, Identifiable, Codable {
    let id: UUID
    let date: Date
    var transcript: String
}

extension Standup {
    static let mock = Self(
        id: Standup.ID(),
        attendees: [
            Attendee(id: Attendee.ID(), name: "Blob"),
            Attendee(id: Attendee.ID(), name: "Blob Jr"),
            Attendee(id: Attendee.ID(), name: "Blob Sr"),
            Attendee(id: Attendee.ID(), name: "Blob Seq"),
            Attendee(id: Attendee.ID(), name: "Blob III"),
            Attendee(id: Attendee.ID(), name: "Blob I")
        ],
        duration: .seconds(60),
        meetings: [
            Meeting(id: Meeting.ID(),
                    date: Date(),
                    transcript: "transcript")
        ],
        theme: .bubblegum,
        title: "title"
    )
}
