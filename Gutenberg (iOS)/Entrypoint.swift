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
import UIKit

/// The main entry point of the app.
@main
struct GutenbergApp: App {
    @State private var sourceModel = GutenbergSourceEditorViewModel()
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        DocumentGroup(newDocument: JensonDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL)
                .environmentObject(sourceModel)
//                .navigationBarTitleDisplayMode(.inline)
        }
        .commands {
            TextEditingCommands()
            CommandGroup(replacing: .textFormatting) { Text("Removed") }
            GutenbergSourceEditorMenu(model: sourceModel)
#if targetEnvironment(macCatalyst)
            CommandGroup(after: .toolbar) {
                Divider()
                GutenbergSettingsMenu()
                Divider()
                JensonThemePicker()
            }
#endif
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    override func buildMenu(with builder: UIMenuBuilder) {
        if builder.system == .main {
            builder.remove(menu: .format)
        }
    }
}
