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
    @Binding var document: GutenbergDocument

    @EnvironmentObject var sourceModel: GutenbergSourceEditorViewModel

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
            .findNavigator(presentationStyle: $sourceModel.findNavigationState)
            .environment(\.colorScheme, systemAppearance)
            .introspectViewController { viewController in
                withAnimation {
                    viewController.view.backgroundColor = .systemBackground
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(id: "sourceeditor") {
                GutenbergSourceEditorToolbar()
            }
    }
}
