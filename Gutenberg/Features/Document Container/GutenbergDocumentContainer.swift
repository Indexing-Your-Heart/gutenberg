//
//  GutenbergDocumentContainer.swift
//  Created by Marquis Kurt on 9/20/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import JensonKit
import SwiftUI

/// A view that acts as a wrapper around a document.
struct GutenbergDocumentContainer<WrappedContent: View>: View {
    @ObservedObject var documentVM: GutenbergDocumentContainerViewModel
    var wrappedContent: (Binding<GutenbergDocument>) -> WrappedContent

    private var documentImageView: some View {
        Image(systemName: "text.book.closed.fill")
            .imageScale(.large)
            .foregroundColor(.black)
    }

    var body: some View {
        wrappedContent(documentVM.document)
            .navigationTitle(documentVM.documentTitle)
            .toolbarTitleMenu {
                Button {
                    documentVM.showRenameAction.toggle()
                } label: {
                    Label("Rename", systemImage: "pencil")
                }
                .disabled(documentVM.shouldDisableRenameAction())
                Button {
                    documentVM.showFileExporter.toggle()
                } label: {
                    Label(documentVM.getExportNameAction(), systemImage: "plus.square.on.square")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDocument(
                documentVM.document.wrappedValue,
                preview: SharePreview(documentVM.documentTitle, icon: documentVM.documentImage)
            )
            .fileMover(isPresented: $documentVM.showRenameAction, file: documentVM.fileURL, onCompletion: handleFile)
            .fileExporter(
                isPresented: $documentVM.showFileExporter,
                document: documentVM.document.wrappedValue,
                contentType: .jenson,
                defaultFilename: documentVM.getDocumentTitleForExport(),
                onCompletion: handleFile
            )
            .onAppear {
                Task {
                    await getDocumentImage()
                }
            }
            .onChange(of: documentVM.document.wrappedValue.jsonRepresentation) { _ in
                documentVM.updateDocumentTitleFromJSONRepresentation()
            }
            .alert(
                "This file uses an outdated format without compression.",
                isPresented: $documentVM.showDecompressionWarning
            ) {
                Button("OK") {
                    documentVM.acknowledgeDecompressionWarning()
                }
            } message: {
                Text("This file will be converted to the new format when you save changes.")
            }
            .alert(
                "This file was imported from a Markdown source document and cannot be edited.",
                isPresented: $documentVM.showTranslationFromMarkdownWarning
            ) {
                Button("Open Anyway") {
                    documentVM.acknowledgeMarkdownConversionWarning()
                }
                Button("Make a Copy") {
                    documentVM.acknowledgeMarkdownConversionWarning()
                    documentVM.showFileExporter.toggle()
                }
                .keyboardShortcut(.defaultAction)
            } message: {
                Text(
                    "You can continue previewing the file, or you can make a copy of the current file in the Jenson "
                    + "format make changes."
                )
            }
    }

    private func getDocumentImage() async {
        let renderer = ImageRenderer(content: documentImageView)
        if let uiImage = renderer.uiImage {
            documentVM.documentImage = Image(uiImage: uiImage)
        }
    }

    private func handleFile(_ result: Result<URL, Error>) {
        if case .failure(let failure) = result {
            print(failure)
        }
    }
}
