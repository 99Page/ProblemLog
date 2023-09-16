/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct CardView: View {
    let standup: Standup
    var body: some View {
        VStack(alignment: .leading) {
            Text(standup.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(standup.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(standup.attendees.count) attendees")
                Spacer()
                Label(standup.duration.formatted(.units()), systemImage: "clock")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(standup.theme.accentColor)
    }
}
