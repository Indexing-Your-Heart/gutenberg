//
//  ContentView.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

/// The primary content view of the app.
struct ContentView: View {
    /// The pane that should open by default. Defaults to the preview.
    @AppStorage("default-pane") private var preferredDefaultPane: JensonViewerPane = .source

    /// Whether the event count status overlay appears. Defaults to false.
    @AppStorage("display-event-count") private var displayEventCount = false

    /// A binding to the document that will be manipulated.
    @Binding var document: GutenbergDocument

    /// The currently displaying pane.
    @State private var pane = JensonViewerPane.preview

    /// Whether to show the About dialog.
    @State private var showAbout = false

    @State private var showSettings = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var sourceModel: GutenbergSourceEditorViewModel
    @ObservedObject var documentContainerModel: GutenbergDocumentContainerViewModel

    var body: some View {
        tintedContent {
                GutenbergDocumentContainer(documentVM: documentContainerModel) { doc in
                    Group {
                        switch pane {
                        case .preview:
                            GutenbergPreview(document: doc)
                                .tint(.primary)
                        case .source:
                            GutenbergSourceView(document: doc)
                                .tint(.accentColor)
                                .environmentObject(sourceModel)
                        }
                    }
                }
        }
        .animation(.easeInOut, value: pane)
        .toolbar { toolbar }
        .sheet(isPresented: $showAbout) {
            NavigationStack {
                GutenbergAboutView()
                    .toolbarRole(.automatic)
            }
        }
        .sheet(isPresented: $showSettings) {
            NavigationStack {
                GutenbergSettingsForm()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarRole(.automatic)
                    .toolbar {
                        Button {
                            showSettings = false
                        } label: {
                            Text("Done")
                        }
                    }
            }
        }
        .onAppear {
            pane = document.translatedFromMarkdown ? .preview : preferredDefaultPane
        }
        .overlay(alignment: .bottom) {
            Group {
                if displayEventCount {
                    GutenbergEventCountOverlay(document: document)
                }
            }
            .padding(.bottom, 8)
        }
    }

    @ViewBuilder
    private func tintedContent<Content: View>(content: () -> Content) -> some View {
        content()
            .tint(pane == .preview ? .primary : .accentColor)
    }

    private var toolbar: some ToolbarContent {
        Group {
            #if !targetEnvironment(macCatalyst)
            ToolbarItem(placement: .navigationBarLeading) {
                tintedContent {
                    Menu {
                        GutenbergSidebarMenu()
                        Divider()
                        Button {
                            showSettings.toggle()
                        } label: {
                            Label("Settings", systemImage: "gear")
                        }
                        Button {
                            showAbout.toggle()
                        } label: {
                            Label("About Gutenberg", systemImage: "info.circle")
                        }
                    } label: {
                        Label("View", systemImage: "sidebar.left")
                    }
                }
            }
            #endif
            ToolbarItem(placement: .primaryAction) {
                tintedContent {
                    GutenbergPaneSwitcher(currentPane: $pane, disabled: documentContainerModel.isReadOnly)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            document: .constant(GutenbergDocument()),
            documentContainerModel: .init(with: .constant(GutenbergDocument()), at: nil)
        )
    }
}
