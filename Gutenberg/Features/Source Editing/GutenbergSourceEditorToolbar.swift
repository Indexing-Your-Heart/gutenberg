//
//  GutenbergSourceEditorToolbar.swift
//  Created by Marquis Kurt on 12/6/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergSourceEditorToolbar: CustomizableToolbarContent {
    @EnvironmentObject var sourceModel: GutenbergSourceEditorViewModel

    var body: some CustomizableToolbarContent {
        Group {
            ToolbarItem(id: "nil") {
                EmptyView()
            }
            .customizationBehavior(.disabled)
            #if !targetEnvironment(macCatalyst)
            ToolbarItem(id: "fontsize") {
                ControlGroup {
                    Button {
                        withAnimation { sourceModel.decreaseFontSize() }
                    } label: {
                        Label("Decrease Font Size", systemImage: "textformat.size.smaller")
                    }
                    .keyboardShortcut("-", modifiers: [.command, .shift])
                    Button {
                        withAnimation { sourceModel.resetFontSize() }
                    } label: {
                        Label("Reset Font Size", systemImage: "equal")
                    }
                    .keyboardShortcut("=", modifiers: [.command])
                    Button {
                        withAnimation { sourceModel.increaseFontSize() }
                    } label: {
                        Label("Increase Font Size", systemImage: "textformat.size.larger")
                    }
                    .keyboardShortcut("+", modifiers: [.command])
                } label: {
                    Label("Font Size", systemImage: "character")
                }
                .controlGroupStyle(.navigation)
            }
            ToolbarItem(id: "lineheight") {
                ControlGroup {
                    Button {
                        withAnimation {
                            sourceModel.decreaseLineSpacing()
                        }
                    } label: {
                        Label("Decrease Line Spacing", systemImage: "text.badge.minus")
                    }
                    .keyboardShortcut("-", modifiers: [.command, .option])

                    Button {
                        withAnimation {
                            sourceModel.increaseLineSpacing()
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
                        ToolbarItem(id: "findreplace", placement: .navigationBarTrailing) {
                            Menu {
                                Button {
                                    withAnimation {
                                        sourceModel.findNavigationState = .find
                                    }
                                } label: {
                                    Label("Find", systemImage: "magnifyingglass")
                                }
                                Button {
                                    withAnimation {
                                        sourceModel.findNavigationState = .replace
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
    }
}
