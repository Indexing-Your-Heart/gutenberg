//
//  JensonDialogueCell.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
