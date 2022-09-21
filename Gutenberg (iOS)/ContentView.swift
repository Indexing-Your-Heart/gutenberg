//
//  ContentView.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/19/22.
//

import SwiftUI

/// The primary content view of the app.
struct ContentView: View {
    /// The pane that should open by default. Defaults to the preview.
    @AppStorage("default-pane") private var preferredDefaultPane: JensonViewerPane = .preview

    /// Whether the Narrator character appears on unnamed dialogue events in the preview. Defaults to false.
    @AppStorage("display-narrator") private var displayNarrator = false

    /// Whether to hide non-dialogue events such as comments and refresh events. Defaults to false.
    @AppStorage("hide-misc-events") private var hideMiscEvents = false

    /// A binding to the document that will be manipulated.
    @Binding var document: JensonDocument

    /// The document's file URL. Used for renaming and duplicating files.
    var fileURL: URL?

    /// The currently displaying pane.
    @State private var pane = JensonViewerPane.preview

    /// Whether to show the About dialog.
    @State private var showAbout = false

    var body: some View {
        GutenbergDocumentContainer(document: $document, fileURL: fileURL) { doc in
            Group {
                switch pane {
                case .preview:
                    GutenbergPreview(document: doc)
                case .source:
                    GutenbergSourceView(document: doc)
                }
            }
        }
        .animation(.easeInOut, value: pane)
        .toolbar { toolbar }
        .sheet(isPresented: $showAbout) {
            NavigationStack {
                GutenbergAboutView()
            }
        }
        .onAppear {
            pane = preferredDefaultPane
        }
    }

    private var toolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Menu {
                    Picker("Pane", selection: $pane) {
                        ForEach(JensonViewerPane.allCases, id: \.hashValue) { paneCase in
                            Label(paneCase.rawValue, systemImage: paneCase.systemImage)
                                .tag(paneCase)
                        }
                    }
                } label: {
                    Label("Current View", systemImage: "macwindow.on.rectangle")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker("Default View", selection: $preferredDefaultPane) {
                        ForEach(JensonViewerPane.allCases, id: \.hashValue) { paneCase in
                            Text(paneCase.rawValue).tag(paneCase)
                        }
                    }
                    .pickerStyle(.menu)
                    Toggle(isOn: $displayNarrator) {
                        Label("Show Narrator Name", systemImage: "info.bubble")
                    }
                    Toggle(isOn: $hideMiscEvents) {
                        Label("Hide Scripting Events", systemImage: "bell.slash.circle")
                    }
                    Button {
                        showAbout.toggle()
                    } label: {
                        Label("About Gutenberg", systemImage: "info.circle")
                    }
                } label: {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(JensonDocument()))
    }
}
