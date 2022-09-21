//
//  GutenbergDocumentContainer.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/20/22.
//

import JensonKit
import SwiftUI

/// A view that acts as a wrapper around a document.
struct GutenbergDocumentContainer<WrappedContent: View>: View {
    /// A binding to the open Jenson document.
    @Binding var document: JensonDocument

    /// The document's file URL. Used for renaming and duplicating files.
    var fileURL: URL?

    var wrappedContent: (Binding<JensonDocument>) -> WrappedContent

    /// Whether to show the decompression warning. Defaults to false.
    @State private var showDecompressionWarning = false

    /// Whether to initiate the duplicate action. Defaults to false.
    @State private var showDuplicate = false

    /// Whether to show the document properties view. Defaults to false.
    @State private var showProperties = false

    /// Whether to initiate the rename action. Defaults to false.
    @State private var showRename = false

    /// The document image used when rendering the preview.
    @State private var documentImage = Image(systemName: "text.bubble")

    /// The title of the document.
    @State private var documentTitle = "Untitled Story"

    private var documentImageView: some View {
        Image(systemName: "text.book.closed.fill")
            .imageScale(.large)
            .foregroundColor(.black)
    }

    var body: some View {
        wrappedContent($document)
            .navigationTitle(documentTitle)
            .toolbarTitleMenu {
                RenameButton()
                Button {
                    showDuplicate.toggle()
                } label: {
                    Label("Duplicate", systemImage: "plus.square.on.square")
                }
                Button {
                    showProperties.toggle()
                } label: {
                    Label("Get Info", systemImage: "info.circle")
                }
            }
            .navigationDocument(
                document,
                preview: SharePreview(documentTitle, icon: documentImage)
            )
            .renameAction { showRename.toggle() }
            .fileMover(isPresented: $showRename, file: fileURL, onCompletion: handleFile)
            .fileExporter(
                isPresented: $showDuplicate,
                document: document,
                contentType: .jenson,
                onCompletion: handleFile
            )
            .sheet(isPresented: $showProperties) {
                NavigationStack {
                    JensonDocumentPropertiesView(document: $document)
                        .listRowSeparator(.hidden)
                        .toolbar {
                            Button {
                                showProperties = false
                            } label: {
                                Text("Done")
                            }
                        }
                }
                .presentationDetents([.medium, .large])
            }
            .onAppear {
                if document.readDecompressedFile { showDecompressionWarning.toggle() }
                if let name = document.story?.name { documentTitle = name }
                Task {
                    await getDocumentImage()
                }
            }
            .onChange(of: document.jsonRepresentation) { _ in
                if let updated = document.updateRepresentationToContents(), let name = updated.story?.name {
                    documentTitle = name
                }
            }
            .alert("This file uses an outdated format without compression.", isPresented: $showDecompressionWarning) {
                Button("OK") {}
            } message: {
                Text("This file will be converted to the new format when you save changes.")
            }
    }

    private func getDocumentImage() async {
        let renderer = await ImageRenderer(content: documentImageView)
        if let uiImage = await renderer.uiImage {
            documentImage = Image(uiImage: uiImage)
        }
    }

    private func handleFile(_ result: Result<URL, Error>) {
        if case let .failure(failure) = result {
            print(failure)
        }
    }
}
