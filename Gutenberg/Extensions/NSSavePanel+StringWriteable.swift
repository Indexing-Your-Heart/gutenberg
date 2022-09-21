//
//  NSSavePanel+StringWriteable.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/17/22.
//

import AppKit
import UniformTypeIdentifiers

extension NSSavePanel {
    /// Initializes a save panel with the allowed content types.
    convenience init(allowing allowedContentTypes: [UTType], hidesExtensions: Bool) {
        self.init()
        self.allowedContentTypes = allowedContentTypes
        isExtensionHidden = hidesExtensions
    }

    /// Displays the save dialog and attempts to write the string to a file.
    func save(string stringContent: String) {
        if let window = NSApplication.shared.mainWindow {
            beginSheetModal(for: window) { [weak self] response in
                do {
                    try self?.writeOn(response: response, contents: stringContent)
                } catch {
                    DispatchQueue.main.async {
                        window.presentError(error)
                    }
                }
            }
        } else {
            do {
                try writeOn(response: runModal(), contents: stringContent)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.presentError(error)
                }
            }
        }
    }

    private func writeOn(response: NSApplication.ModalResponse, contents: String) throws {
        guard response == .OK, let url else { return }
        try contents.write(to: url, atomically: true, encoding: .utf8)
    }
}
