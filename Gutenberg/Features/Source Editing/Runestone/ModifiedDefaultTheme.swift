//
//  ModifiedDefaultTheme.swift
//  Created by Marquis Kurt on 9/20/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Runestone
import UIKit

/// A Runestone editor theme that respects user settings for font.
class ModifiedDefaultTheme: Theme {
    var font: UIFont = .monospacedSystemFont(ofSize: 13.0, weight: .regular)
    var textColor: UIColor = DefaultTheme().textColor
    var gutterBackgroundColor: UIColor = DefaultTheme().gutterBackgroundColor
    var gutterHairlineColor: UIColor = DefaultTheme().gutterHairlineColor
    var lineNumberColor: UIColor = DefaultTheme().lineNumberColor
    var lineNumberFont: UIFont = .monospacedSystemFont(ofSize: 13.0, weight: .regular)
    var selectedLineBackgroundColor: UIColor = DefaultTheme().selectedLineBackgroundColor
    var selectedLinesLineNumberColor: UIColor = DefaultTheme().selectedLinesLineNumberColor
    var selectedLinesGutterBackgroundColor: UIColor = DefaultTheme().selectedLinesGutterBackgroundColor
    var invisibleCharactersColor: UIColor = DefaultTheme().invisibleCharactersColor
    var pageGuideHairlineColor: UIColor = DefaultTheme().pageGuideHairlineColor
    var pageGuideBackgroundColor: UIColor = DefaultTheme().pageGuideBackgroundColor
    var markedTextBackgroundColor: UIColor = DefaultTheme().markedTextBackgroundColor

    func textColor(for highlightName: String) -> UIColor? {
        DefaultTheme().textColor(for: highlightName)
    }

    init(with fontSize: CGFloat) {
        font = .monospacedSystemFont(ofSize: fontSize, weight: .regular)
        lineNumberFont = .monospacedSystemFont(ofSize: fontSize, weight: .regular)
    }
}
