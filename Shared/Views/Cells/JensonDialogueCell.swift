//
//  JensonDialogueCell.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
//

import Foundation
import JensonKit
import SwiftUI

/// A view that displays dialogue.
struct JensonDialogueCell: View {
    /// Whether to display the "Narrator" name on dialogue events without a name. Defaults to false.
    @AppStorage("display-narrator") private var displayNarrator = false

    /// The event that will be rendered into the cell.
    var event: JensonEvent

    var body: some View {
        Group {
            if !event.who.isEmpty || displayNarrator {
                PaddedHStack {
                    VStack {
                        Text(event.who.isEmpty ? "Narrator" : event.who)
                            .bold()
                            .textCase(.uppercase)
                        Text(event.what.attributed())
                    }
                }
            } else {
                Text(event.what.attributed())
            }
        }
    }
}
