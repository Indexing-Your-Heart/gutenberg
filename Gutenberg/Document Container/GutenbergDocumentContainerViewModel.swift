//
//  GutenbergDocumentViewModel.swift
//  Created by Marquis Kurt on 11/30/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI
import Combine

class GutenbergDocumentContainerViewModel: ObservableObject {
    /// A binding to the document that the container will access.
    @Published var document: Binding<JensonDocument>

    /// The document's file URL. Used for renaming and duplicating files.
    @Published var fileURL: URL?

    // Whether to show the decompression warning. Defaults to false.
    @Published var showDecompressionWarning = false

    /// Whether to initiate the duplicate/save as action. Defaults to false.
    @Published var showFileExporter = false

    /// Whether to show the document properties view. Defaults to false.
    @Published var showPropertiesWindow = false

    /// Whether to initiate the rename action. Defaults to false.
    @Published var showRenameAction = false

    /// Whether to show the Markdown translation warning. Defaults to false.
    @Published var showTranslationFromMarkdownWarning = false

    /// The document image used when rendering the preview.
    @Published var documentImage = Image(systemName: "text.bubble")

    /// The title of the document.
    @Published var documentTitle = "Untitled Story"

    /// Whether to display the alert for a Markdown conversion warning from user preferences.
    @AppStorage("warn-markdown-convert") private var warnMarkdownConvert = true

    /// Whether the document is read-only.
    var isReadOnly: Bool {
        return document.wrappedValue.translatedFromMarkdown
    }

    private var didDisplayDecompressedWarning = false
    private var didDisplayMarkdownWarning = false

    init(with document: Binding<JensonDocument>, at path: URL?) {
        self.document = document
        self.fileURL = path

        if document.wrappedValue.readDecompressedFile {
            showDecompressionWarning = true
        }

        if document.wrappedValue.translatedFromMarkdown, warnMarkdownConvert {
            showTranslationFromMarkdownWarning = true
        }

        if let name = document.wrappedValue.story?.name { documentTitle = name }
        if let chapter = document.wrappedValue.story?.chapter {
            documentTitle = "\(chapter) - \(documentTitle)"
        }
    }

    func acknowledgeDecompressionWarning() {
        didDisplayDecompressedWarning = true
        showDecompressionWarning = false
    }

    func acknowledgeMarkdownConversionWarning() {
        didDisplayMarkdownWarning = true
        showTranslationFromMarkdownWarning = false
    }

    func getDocumentTitleForExport() -> String {
        documentTitle + (didDisplayMarkdownWarning ? "" : " (Duplicate)")
    }

    func getExportNameAction() -> String {
        didDisplayMarkdownWarning ? "Save As..." : "Duplicate..."
    }

    func hidePropertiesWindow() {
        showPropertiesWindow = false
    }

    func shouldDisableRenameAction() -> Bool {
        return didDisplayMarkdownWarning
    }

    func updateDocumentTitleFromJSONRepresentation() {
        if let updated = document.wrappedValue.updateRepresentationToContents(), let name = updated.story?.name {
            documentTitle = name
        }
    }
}
