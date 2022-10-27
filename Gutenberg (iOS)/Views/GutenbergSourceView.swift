//
//  GutenbergSourceView.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Introspect
import SwiftUI

/// A view that displays the source of a Jenson file that users can edit.
struct GutenbergSourceView: View {
    /// The current color scheme.
    @Environment(\.colorScheme) var defaultColorScheme

    /// A binding to the Jenson document.
    @Binding var document: JensonDocument

    @EnvironmentObject var sourceModel: GutenbergSourceEditorViewModel

    /// The current find and replace state.
    @State private var findNavigationState = RunestoneEditor.FindInteractionStyle.disabled

    /// The current appearance of the editor view.
    private var systemAppearance: ColorScheme {
        guard let darkModeEnabled = sourceModel.darkModeEnabled else { return defaultColorScheme }
        return darkModeEnabled ? .dark : .light
    }

    var body: some View {
        RunestoneEditor(text: $document.jsonRepresentation)
            .showLineNumbers(sourceModel.lineNumbersVisible)
            .lineSpacing(sourceModel.lineSpacing)
            .fontSize(sourceModel.fontSize)
            .lineWrapping(sourceModel.lineWrapping)
            .findNavigator(presentationStyle: $findNavigationState)
            .environment(\.colorScheme, systemAppearance)
            .introspectViewController { viewController in
                withAnimation {
                    viewController.view.backgroundColor = .systemBackground
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(id: "sourceeditor") {
                ToolbarItem(id: "nil") {
                    EmptyView()
                }
                .customizationBehavior(.disabled)
                #if !targetEnvironment(macCatalyst)
                ToolbarItem(id: "fontsize") {
                    ControlGroup {
                        Button {
                            withAnimation { sourceModel.fontSize -= 1 }
                        } label: {
                            Label("Decrease Font Size", systemImage: "textformat.size.smaller")
                        }
                        .keyboardShortcut("-", modifiers: [.command, .shift])
                        Button {
                            withAnimation { sourceModel.fontSize = 13 }
                        } label: {
                            Label("Reset Font Size", systemImage: "equal")
                        }
                        .keyboardShortcut("=", modifiers: [.command])
                        Button {
                            withAnimation { sourceModel.fontSize += 1 }
                        } label: {
                            Label("Increase Font Size", systemImage: "textformat.size.larger")
                        }
                        .keyboardShortcut("+", modifiers: [.command])
                    } label: {
                        Label("Font Size", systemImage: "character")
                    }
                }
                ToolbarItem(id: "lineheight") {
                    ControlGroup {
                        Button {
                            withAnimation {
                                sourceModel.lineSpacing = max(1.0, sourceModel.lineSpacing - 0.25)
                            }
                        } label: {
                            Label("Decrease Line Spacing", systemImage: "text.badge.minus")
                        }
                        .keyboardShortcut("-", modifiers: [.command, .option])

                        Button {
                            withAnimation {
                                sourceModel.lineSpacing = max(1.0, sourceModel.lineSpacing + 0.25)
                            }
                        } label: {
                            Label("Increase Line Spacing", systemImage: "text.badge.plus")
                        }
                        .keyboardShortcut("+", modifiers: [.command, .option])
                    } label: {
                        Label("Line Spacing", systemImage: "arrow.up.and.down.text.horizontal")
                    }
                }
                ToolbarItem(id: "linenumbers") {
                    Toggle(isOn: $sourceModel.lineNumbersVisible) {
                        Label("Toggle Line Numbers", systemImage: "list.number")
                    }
                    .keyboardShortcut("l", modifiers: [.control, .shift, .command])
                }
                ToolbarItem(id: "linewrapping", showsByDefault: false) {
                    Toggle(isOn: $sourceModel.lineWrapping) {
                        Label("Toggle Line Wrapping", systemImage: "text.append")
                    }
                    .keyboardShortcut("l", modifiers: [.control, .option, .command])
                }
                ToolbarItem(id: "appearance", showsByDefault: false) {
                    Button {
                        withAnimation {
                            if let currentAppearance = sourceModel.darkModeEnabled {
                                sourceModel.darkModeEnabled = !currentAppearance
                            } else { sourceModel.darkModeEnabled = true }
                        }
                    } label: {
                        Label(
                            "Toggle Editor Appearance",
                            systemImage: sourceModel.darkModeEnabled == true ? "moon.circle.fill" : "moon.circle"
                        )
                    }
                }
                ToolbarItem(id: "findreplace", placement: .primaryAction) {
                    Menu {
                        Button {
                            withAnimation {
                                findNavigationState = .find
                            }
                        } label: {
                            Label("Find", systemImage: "magnifyingglass")
                        }
                        Button {
                            withAnimation {
                                findNavigationState = .replace
                            }
                        } label: {
                            Label("Find and Replace", systemImage: "text.magnifyingglass")
                        }
                    } label: {
                        Label("Find/Replace", systemImage: "magnifyingglass.circle")
                    }
                }
                #endif
            }
            .toolbarRole(.editor)
    }
}
