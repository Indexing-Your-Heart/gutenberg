//
//  JensonDocument+AppKit.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import AppKit

extension JensonDocument {
    /// Displays an `NSAlert` if the open document was uncompressed.
    func displayConversionWarningIfUncompressedRead() {
        guard readDecompressedFile else { return }
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = "This file uses an outdated format without compression."
            alert.informativeText = "This file will be converted to the new format when you save changes."
            if let window = NSApplication.shared.mainWindow {
                alert.beginSheetModal(for: window) { _ in }
            } else {
                alert.runModal()
            }
        }
    }

    /// Exports the JSON representation to a JSON or text file.
    func exportJSONRepresentationFile() {
        let panel = NSSavePanel(allowing: [.json, .text], hidesExtensions: true)
        panel.canCreateDirectories = true
        panel.allowsOtherFileTypes = true
        panel.save(string: jsonRepresentation)
    }
}
