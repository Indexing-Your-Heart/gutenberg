//
//  DebuggingCommands.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/17/22.
//

import SwiftUI

/// A struct that contains the command group for debugging.
struct DebuggingCommands: View {
    /// A focused binding to the currently open document.
    @FocusedBinding(\.document) var document: JensonDocument?

    /// A focused binding to the currently present validator.
    @FocusedBinding(\.validator) var validator: FileValidator?

    var body: some View {
        Group {
            Button {
                validator?.validate()
            } label: {
                Label("Revalidate...", systemImage: "gear")
            }
            Button {
                document?.exportJSONRepresentationFile()
            } label: {
                Label("Export Debugging JSON...", systemImage: "square.and.arrow.up")
            }
            .keyboardShortcut(.init("e", modifiers: [.command]))
        }
    }
}
