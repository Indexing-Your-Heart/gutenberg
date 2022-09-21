//
//  TextView+Convenience.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/20/22.
//

import Foundation
import Runestone

extension TextView {
    /// Creates a TextView with autocorrect features disabled.
    static func withDisabledAutocorrect() -> TextView {
        let textView = TextView()
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        return textView
    }
}
