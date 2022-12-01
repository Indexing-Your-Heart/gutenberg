//
//  JensonQuestionCell.swift
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

/// A view that displays a question along with choices a player can make.
struct JensonQuestionCell: View {
    /// The event that will be rendered into the cell.
    var event: JensonEvent

    var body: some View {
        Group {
            if let question = event.question {
                VStack(alignment: .leading, spacing: 16) {
                    Divider()
                    Text("**BRANCH**: \(question.question)")
                    ForEach(question.options, id: \.self) { choice in
                        JensonChoiceGroup(choice: choice)
                    }
                    Text("**END OF BRANCH**")
                    Divider()
                }
            } else {
                PaddedHStack {
                    Label("Question missing from question type", systemImage: "exclamationmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
