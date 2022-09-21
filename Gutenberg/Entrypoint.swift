//
//  Entrypoint.swift
//  Created by Marquis Kurt on 9/8/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

/// The main entrypoint of the app.
@main struct GutenbergApp: App {
    /// The current pane that is being displayed.
    @State private var pane: JensonViewerPane = .preview

    var body: some Scene {
        DocumentGroup(newDocument: JensonDocument()) { file in
            ContentView(document: file.$document, pane: $pane)
                .focusedSceneValue(\.document, file.$document)
                .focusedSceneValue(\.validator, .constant(JensonFileValidator(document: file.document)))
        }
        .commands {
            SidebarCommands()
            ToolbarCommands()
            TextEditingCommands()
            CommandMenu("Debug") {
                DebuggingCommands()
            }
            CommandGroup(after: .toolbar) {
                PreviewPreferenceCommands(pane: $pane)
            }
        }
        Settings {
            JensonSettingsView()
        }
    }
}
