//
//  JensonCommentCell.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
//

import Foundation
import JensonKit
import SwiftUI

/// A view that represents a comment.
struct JensonCommentCell: View {
    /// The event that will be rendered into the cell.
    var event: JensonEvent

    var body: some View {
        Label {
            Text(event.what.attributed())
                .italic()
        } icon: {
            Image(systemName: "chevron.forward")
        }
        .foregroundColor(.secondary)
    }
}
