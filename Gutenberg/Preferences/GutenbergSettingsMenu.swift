//
//  ContentView.swift
//  Created by Marquis Kurt on 10/27/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation
import SwiftUI

/// A menu for housing the app's general settings.
struct GutenbergSettingsMenu: View {
    /// The pane that should open by default. Defaults to the preview.
    @AppStorage("default-pane") private var preferredDefaultPane: JensonViewerPane = .source

    /// Whether the Narrator character appears on unnamed dialogue events in the preview. Defaults to false.
    @AppStorage("display-narrator") private var displayNarrator = false

    /// Whether to hide non-dialogue events such as comments and refresh events. Defaults to false.
    @AppStorage("hide-misc-events") private var hideMiscEvents = false

    /// Whether to display an alert when a Markdown document was converted into Jenson. Defaults to true.
    @AppStorage("warn-markdown-convert") private var warnMarkdownConversion = true

    var body: some View {
        Group {
            Picker("Default View", selection: $preferredDefaultPane) {
                ForEach(JensonViewerPane.allCases, id: \.hashValue) { paneCase in
                    Text(paneCase.rawValue).tag(paneCase)
                }
            }
            .pickerStyle(.menu)
            Toggle(isOn: $displayNarrator) {
                Label("Show Narrator Name", systemImage: "info.bubble")
            }
            Toggle(isOn: $hideMiscEvents) {
                Label("Hide Scripting Events", systemImage: "bell.slash.circle")
            }
            Toggle(isOn: $warnMarkdownConversion) {
                Label("Show Markdown Import Warning", systemImage: "doc.badge.gearshape")
            }
        }
    }
}
