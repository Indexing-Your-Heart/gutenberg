//
//  PreviewPreferenceCommands.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

/// A struct that contains the command group for the preview pane.
struct PreviewPreferenceCommands: View {
    /// Whether the preview pane should fill the available space. Defaults to false.
    @AppStorage("use-full-width") private var fullWidth = false

    /// A binding to the current pane selection, which is used to directly control it.
    @Binding var pane: JensonViewerPane

    var body: some View {
        Group {
            JensonThemePicker()
            Button {
                withAnimation {
                    fullWidth.toggle()
                }
            } label: {
                Label("Fill Available Space", systemImage: "circle")
            }
            .keyboardShortcut(.init("/", modifiers: [.command, .option]))

            Button {
                let oldPane = pane
                pane = oldPane == .preview ? .source : .preview
            } label: {
                Label("Toggle Preview", systemImage: "circle")
            }
            .keyboardShortcut(.init("p", modifiers: [.command, .option]))
        }
    }
}
