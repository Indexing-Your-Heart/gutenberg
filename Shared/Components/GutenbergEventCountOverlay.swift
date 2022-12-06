//
//  GutenbergEventCountOverlay.swift
//  Created by Marquis Kurt on 12/5/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergEventCountOverlay: View {
    enum DisplayMode: String, CaseIterable {
        case allEvents = "All Events"
        case dialogueOnly = "Dialogue Events"
        case refreshEvents = "Refresh Events"
        case comments = "Comments"
    }

    @State private var showOptions = false
    @AppStorage("event-overlay-display-mode") private var displayMode: DisplayMode = .allEvents

    var document: GutenbergDocument

    var body: some View {
        Text(eventCount)
            .font(.subheadline)
            .bold()
            .foregroundColor(.secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.thinMaterial, in: Capsule())
            .animation(.easeInOut, value: displayMode)
            .onTapGesture {
                showOptions.toggle()
            }
            .popover(isPresented: $showOptions) {
                Form {
                    displayModePicker
                }
                .frame(minWidth: 300, minHeight: 200)
                .formStyle(.grouped)
            }
    }

    var displayModePicker: some View {
        Picker("", selection: $displayMode) {
            ForEach(DisplayMode.allCases, id: \.hashValue) { displayCase in
                Text(displayCase.rawValue).tag(displayCase)
            }
        }
        .pickerStyle(.inline)
    }

    var eventCount: String {
        switch displayMode {
        case .allEvents:
            return "\(document.timeline.count) events"
        case .dialogueOnly:
            let count = document.timeline.filter { $0.type == .dialogue }.count
            return "\(count) dialogues"
        case .refreshEvents:
            let count = document.timeline.filter { $0.type == .refresh }.count
            return "\(count) refresh triggers"
        case .comments:
            let count = document.timeline.filter { $0.type == .comment }.count
            return "\(count) comments"
        }
    }
}
