//
//  Attendee.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/31.
//

import Foundation

struct Attendee: Equatable, Identifiable, Codable {
  let id: UUID
  var name = ""
}
