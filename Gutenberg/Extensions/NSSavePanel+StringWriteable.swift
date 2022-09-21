//
//  NSSavePanel+StringWriteable.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
