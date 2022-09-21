//
//  JensonSettingsView.swift
//  Created by Marquis Kurt on 9/9/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

/// A view that houses settings the user can configure.
struct JensonSettingsView: View {
    var body: some View {
        JensonSettings_Appearance()
            .frame(width: 600, height: 200)
    }
}

private struct JensonSettings_Appearance: View {
    @AppStorage("display-narrator") private var displayNarrator = false
    @AppStorage("default-pane") var defaultPane = JensonViewerPane.preview
    @AppStorage("use-full-width") var fullWidth = false
    @AppStorage("hide-misc-events") private var hideMiscEvents = false

    var body: some View {
        Form {
            Picker("When opening a file, display: ", selection: $defaultPane) {
                ForEach(JensonViewerPane.allCases, id: \.hashValue) { pane in
                    Text(pane.rawValue).tag(pane)
                }
            }
            .pickerStyle(.menu)
            Section {
                JensonThemePicker()
                    .labelStyle(.titleOnly)
                Toggle(isOn: $fullWidth) {
                    Text("Fill available space")
                }
                Toggle(isOn: $displayNarrator) {
                    VStack(alignment: .leading) {
                        Text("Display narrator character name")
                        Text("Character-less events will be assigned to 'Narrator'.")
                            .foregroundColor(.secondary)
                    }
                }
                Toggle(isOn: $hideMiscEvents) {
                    VStack(alignment: .leading) {
                        Text("Hide scripting events")
                        Text("Non-dialogue events such as refresh events will be hidden.")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}

struct JensonSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        JensonSettingsView()
    }
}
