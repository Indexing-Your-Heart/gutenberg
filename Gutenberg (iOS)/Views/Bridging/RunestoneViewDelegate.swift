//
//  RunestoneViewDelegate.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/20/22.
//

import Runestone
import SwiftUI

/// A delegate class used in the Runestone editor view to update bound text.
class RunestoneViewDelegate: TextViewDelegate {
    /// The text that will be bound to this view.
    @Binding var text: String

    init(text: Binding<String>) {
        _text = text
    }

    func textViewDidChange(_ textView: TextView) {
        text = textView.text
    }
}
