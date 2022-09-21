//
//  String+AttributedString.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/16/22.
//

import Foundation

extension String {
    /// Returns an attributed string from the current string. Interprets as Markdown and returns a plain-text version if the conversion fails.
    func attributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString(stringLiteral: self)
        }
    }
}
