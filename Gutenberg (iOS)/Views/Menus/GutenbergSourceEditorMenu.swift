//
//  GutenbergSourceEditorMenu.swift
//  Created by Marquis Kurt on 10/27/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation
import SwiftUI

/// A menu that houses source editor options.
/// This is typically used on the Catalyst version of the app.
struct GutenbergSourceEditorMenu: Commands {
    @ObservedObject var model: GutenbergSourceEditorViewModel

    var body: some Commands {
        CommandMenu("Editor") {
            fontSizeGroup
            Divider()
            viewGroup
            Divider()
            spacingGroup
        }
    }

    var fontSizeGroup: some View {
        Group {
            Button {
                withAnimation { model.fontSize += 1 }
            } label: {
                Label("Increase Font Size", systemImage: "textformat.size.larger")
            }
            .keyboardShortcut("+", modifiers: [.command])
            Button {
                withAnimation { model.fontSize -= 1 }
            } label: {
                Label("Decrease Font Size", systemImage: "textformat.size.smaller")
            }
            .keyboardShortcut("-", modifiers: [.command, .shift])
            Button {
                withAnimation { model.fontSize = 13 }
            } label: {
                Label("Reset Font Size", systemImage: "equal")
            }
            .keyboardShortcut("=", modifiers: [.command])
        }
    }

    var viewGroup: some View {
        Group {
            Toggle(isOn: $model.lineNumbersVisible) {
                Label("Toggle Line Numbers", systemImage: "list.number")
            }
            .keyboardShortcut("l", modifiers: [.control, .shift, .command])
            Toggle(isOn: $model.lineWrapping) {
                Label("Toggle Line Wrapping", systemImage: "text.append")
            }
            .keyboardShortcut("l", modifiers: [.control, .option, .command])
        }
    }

    var spacingGroup: some View {
        Group {
            Button {
                withAnimation {
                    model.lineSpacing = max(1.0, model.lineSpacing - 0.25)
                }
            } label: {
                Label("Decrease Line Spacing", systemImage: "text.badge.minus")
            }
            .keyboardShortcut("-", modifiers: [.command, .option])

            Button {
                withAnimation {
                    model.lineSpacing = max(1.0, model.lineSpacing + 0.25)
                }
            } label: {
                Label("Increase Line Spacing", systemImage: "text.badge.plus")
            }
            .keyboardShortcut("+", modifiers: [.command, .option])
        }
    }
}
