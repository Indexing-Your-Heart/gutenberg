//
//  GutenbergSidebarMenu.swift
//  Created by Marquis Kurt on 12/5/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergSidebarMenu: View {
    /// Whether the Narrator character appears on unnamed dialogue events in the preview. Defaults to false.
    @AppStorage("display-narrator") private var displayNarrator = false

    /// Whether the event count status overlay appears. Defaults to false.
    @AppStorage("display-event-count") private var displayEventCount = false

    /// Whether to display the outline in the preview.
    @AppStorage("display-preview-outline") private var displayPreviewOutline = false

    /// Whether to hide non-dialogue events such as comments and refresh events. Defaults to false.
    @AppStorage("hide-misc-events") private var hideMiscEvents = false

    @Environment(\.openWindow) var openWindow

    var body: some View {
        Group {
            AnimatedButton {
                displayPreviewOutline.toggle()
            } label: {
                Label(
                    displayPreviewOutline ? "Hide Preview Outline" : "Show Preview Outline",
                    systemImage: "list.bullet.rectangle"
                )
            }
            Divider()
            AnimatedButton {
                displayNarrator.toggle()
            } label: {
                Label(
                    displayNarrator ? "Hide Narrator Name" : "Show Narrator Name",
                    systemImage: "info.bubble"
                )
            }
            AnimatedButton {
                openWindow(id: "documentation")
            } label: {
                Label(
                    "Documentation",
                    systemImage: "book.circle"
                )
            }
            Divider()
            AnimatedButton {
                hideMiscEvents.toggle()
            } label: {
                Label(
                    hideMiscEvents ? "Show Scripted Events" : "Hide Scripted Events",
                    systemImage: "bell.slash.circle"
                )
            }
            AnimatedButton {
                displayEventCount.toggle()
            } label: {
                Label(
                    displayEventCount ? "Hide Event Count" : "Show Event Count",
                    systemImage: "123.rectangle"
                )
            }
        }
    }
}
