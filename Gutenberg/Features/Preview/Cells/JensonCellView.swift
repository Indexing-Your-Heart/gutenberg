//
//  JensonCellView.swift
//  Created by Marquis Kurt on 9/8/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import JensonKit
import SwiftUI

/// A struct that represents a cell in the Jenson preview.
struct JensonCellView: View {
    /// The event that this cell refers to.
    @State var event: JensonEvent

    /// Whether to hide non-dialogue events such as refresh events. Defaults to false.
    @AppStorage("hide-misc-events") private var hideMiscEvents = false

    var body: some View {
        Group {
            switch event.type {
            case .comment:
                JensonCommentCell(event: event)
            case .dialogue:
                JensonDialogueCell(event: event)
            case .question:
                JensonQuestionCell(event: event)
            case .refresh where !hideMiscEvents:
                JensonRefreshEventCell(event: event)
            case .refresh where hideMiscEvents:
                EmptyView()
            default:
                PaddedHStack {
                    Label("Unknown event type: '\(event.type.rawValue)'", systemImage: "exclamationmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

struct JensonCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            ForEach(JensonFile.template.timeline) { event in
                JensonCellView(event: event)
            }
        }
    }
}
