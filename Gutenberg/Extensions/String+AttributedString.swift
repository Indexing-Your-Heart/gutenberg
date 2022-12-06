//
//  String+AttributedString.swift
//  Created by Marquis Kurt on 9/16/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation

extension String {
    /// Returns an attributed string from the current string. Interprets as Markdown and returns a plain-text version
    /// if the conversion fails.
    func attributed() -> AttributedString {
        do {
            return try AttributedString(
                markdown: self,
                options: .init(
                    allowsExtendedAttributes: true,
                    interpretedSyntax: .inlineOnlyPreservingWhitespace,
                    failurePolicy: .returnPartiallyParsedIfPossible
                )
            )
        } catch {
            return AttributedString(stringLiteral: self)
        }
    }
}
