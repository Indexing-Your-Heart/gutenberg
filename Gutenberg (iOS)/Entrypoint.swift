//
//  Entrypoint.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/19/22.
//

import SwiftUI

/// The main entry point of the app.
@main
struct GutenbergApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: JensonDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL)
                .navigationBarTitleDisplayMode(.inline)
        }
        .commands {
            TextEditingCommands()
        }
    }
}
