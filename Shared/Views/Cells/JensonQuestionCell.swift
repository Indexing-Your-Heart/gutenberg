//
//  JensonQuestionCell.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
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
                Divider()
                Text("**BRANCH**: \(question.question)")
                ForEach(question.options, id: \.self) { choice in
                    JensonChoiceGroup(choice: choice)
                }
                Text("**END OF BRANCH**")
                Divider()
            } else {
                PaddedHStack {
                    Label("Question missing from question type", systemImage: "exclamationmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
