//
//  GutenbergSourceEditorViewModel.swift
//  Created by Marquis Kurt on 10/27/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation
import Combine

class GutenbergSourceEditorViewModel: ObservableObject {
    /// Whether dark mode should be enabled on the source view.
    @Published var darkModeEnabled: Bool?

    /// The editor's font size.
    @Published var fontSize: CGFloat = 13.0

    /// The spacing between lines.
    @Published var lineSpacing: CGFloat = 1.2

    /// Whether line numbers should be visible.
    @Published var lineNumbersVisible = true

    /// Whether line wrapping is enabled.
    @Published var lineWrapping = true

    /// The current find and replace state.
    @Published var findNavigationState = RunestoneEditor.FindInteractionStyle.disabled

    func increaseFontSize() {
        fontSize += 1
    }

    func decreaseFontSize() {
        fontSize -= 1
    }

    func resetFontSize() {
        fontSize = 13
    }

    func increaseLineSpacing() {
        lineSpacing = max(1.0, lineSpacing + 0.25)
    }

    func decreaseLineSpacing() {
        lineSpacing = max(1.0, lineSpacing - 0.25)
    }
}
