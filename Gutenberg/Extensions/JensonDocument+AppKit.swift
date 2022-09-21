//
//  JensonDocument+AppKit.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
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
