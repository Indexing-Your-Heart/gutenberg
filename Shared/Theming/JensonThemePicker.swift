//
//  JensonThemePicker.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
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
