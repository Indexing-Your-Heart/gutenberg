//
//  RunestoneViewDelegate.swift
//  Created by Marquis Kurt on 9/20/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Runestone
import SwiftUI

/// A delegate class used in the Runestone editor view to update bound text.
class RunestoneEditorDelegate: TextViewDelegate {
    /// The text that will be bound to this view.
    @Binding var text: String

    init(text: Binding<String>) {
        _text = text
    }

    func textViewDidChange(_ textView: TextView) {
        text = textView.text
    }
}
