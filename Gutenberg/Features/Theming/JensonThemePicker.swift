//
//  JensonThemePicker.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation
import SwiftUI

struct JensonThemePicker: View {
    /// The preview's theme. Defaults to Manuscript.
    @AppStorage("preview-theme") private var theme = PreviewThemeSelection.manuscript

    var body: some View {
        Picker(selection: $theme) {
            ForEach(PreviewThemeSelection.allCases, id: \.self) { themeCase in
                Text(themeCase.rawValue).tag(themeCase)
            }
        } label: {
            Label("Preview Theme", systemImage: "swatchpalette")
        }
    }
}
