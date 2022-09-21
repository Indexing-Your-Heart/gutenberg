//
//  ContentView.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/8/22.
//

import JensonKit
import SwiftUI

/// The primary content view.
struct ContentView: View {
    /// The pane that should open by default. Defaults to the preview.
    @AppStorage("default-pane") private var preferredDefaultPane: JensonViewerPane = .preview

    /// Whether the preview should take the full width of the window. Defaults to false.
    @AppStorage("use-full-width") private var fullWidth = false

    /// A binding to the currently open document.
    @Binding var document: JensonDocument

    /// A binding to the current pane.
    @Binding var pane: JensonViewerPane

    /// A focused binding to the currently available file validator.
    @FocusedBinding(\.validator) var validator: FileValidator?

    /// Whether to show the document properties inspector. Defaults to false.
    @State private var displayFileInformation = false

    /// Whether the preview should be toggled on. Defaults to false.
    @State private var togglePreview: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            if displayFileInformation, pane == .preview, !fullWidth {
                Spacer()
            }

            primaryContent
            if displayFileInformation {
                inspector
            }
        }

        .frame(minWidth: 350, minHeight: 300)
        .navigationSubtitle(Text(subtitle()))
        .toolbar(id: "actions") { toolbarContent }
        .onAppear {
            document.displayConversionWarningIfUncompressedRead()
            pane = preferredDefaultPane
            togglePreview = (pane == .preview)
            validator?.validate()
        }
    }

    private var primaryContent: some View {
        Group {
            switch pane {
            case .preview:
                JensonFilePreview(document: $document)
            case .source:
                JensonSourceView(document: $document)
            }
        }
    }

    private var inspector: some View {
        Group {
            if pane == .preview, !fullWidth {
                Spacer()
            }
            JensonDocumentPropertiesView(document: $document)
                .background(.background)
                .border(.separator)
        }
    }

    private var toolbarContent: some CustomizableToolbarContent {
        Group {
            ToolbarItem(id: "fullwidth", showsByDefault: false) {
                Toggle(isOn: $fullWidth) {
                    Label("Fill Available Space", systemImage: "arrow.left.and.right.square")
                }
                .disabled(pane == .source)
            }
            ToolbarItem(id: "pane") {
                Toggle(isOn: $togglePreview) {
                    Label("Toggle Preview", systemImage: "eye")
                }
                .toggleStyle(.button)
                .onChange(of: togglePreview) { newValue in
                    togglePreview = newValue
                    pane = togglePreview ? .preview : .source
                }
            }

            ToolbarItem(id: "export", showsByDefault: false) {
                Button {
                    document.exportJSONRepresentationFile()
                } label: {
                    Label("Export Debugging JSON", systemImage: "ellipsis.curlybraces")
                        .help("Export the debugging JSON file")
                }
            }

            ToolbarItem(id: "inspector") {
                Button {
                    withAnimation {
                        displayFileInformation.toggle()
                    }
                } label: {
                    Label("Show Information Inspector", systemImage: "info.circle")
                        .help("Show or hide the Information inspector")
                }
            }
        }
    }

    private func subtitle() -> String {
        guard let story = document.story else { return "" }
        return "\(story.chapter ?? "Untitled") - \(story.name)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(JensonDocument()), pane: .constant(.preview))
    }
}
