//
//  Entrypoint.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/8/22.
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
