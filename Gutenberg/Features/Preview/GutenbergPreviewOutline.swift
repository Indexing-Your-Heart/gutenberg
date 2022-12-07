//
//  GutenbergPreviewOutline.swift
//  Created by Marquis Kurt on 12/6/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI
import JensonKit

struct GutenbergPreviewOutline: View {
    @Binding var currentID: String
    var timeline: [JensonEvent]

    var body: some View {
        List {
            Section {
                ForEach(Array(timeline.enumerated()), id: \.element.id) { (index, event) in
                    Label {
                        VStack(alignment: .leading) {
                            Group {
                                switch event.type {
                                case .refresh:
                                    Label(
                                        "Refresh \(event.refresh?.count ?? 0) triggers",
                                        systemImage: "arrow.clockwise.circle"
                                    )
                                case .question:
                                    Label(event.question?.question ?? "Question", systemImage: "questionmark.circle")
                                case .dialogue, .comment:
                                    Label(event.what, systemImage: "text.bubble")
                                default:
                                    Text("Unknown event")
                                }
                            }
                            .font(.subheadline)
                        }
                    } icon: {
                        Text("\(index + 1)")
                            .font(.system(.subheadline, design: .monospaced, weight: .semibold))
                            .foregroundColor(.accentColor)
                            .monospacedDigit()
                            .allowsTightening(true)
                    }

                    .lineLimit(1)
                    .onTapGesture {
                        currentID = event.id.uuidString
                    }
                    .listRowBackground(Color.clear)
                }
            } header: {
                Text("Outline")
            }
            .headerProminence(.increased)
        }
        .frame(maxWidth: 320)
        .tint(.accentColor)
    }
}
