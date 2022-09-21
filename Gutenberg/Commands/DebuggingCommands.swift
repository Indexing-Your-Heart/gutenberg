//
//  DebuggingCommands.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
