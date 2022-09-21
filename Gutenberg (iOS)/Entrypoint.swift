//
//  Entrypoint.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
