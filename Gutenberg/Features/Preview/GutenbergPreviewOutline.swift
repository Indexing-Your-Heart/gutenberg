//
//  GutenbergPreviewOutline.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 12/6/22.
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
                            Text(event.what)
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
