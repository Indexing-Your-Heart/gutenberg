//
//  JensonFilePreview.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/9/22.
//

import Introspect
import JensonKit
import SwiftUI

/// A view that displays a preview of the Jenson file in a human-readable manner.
struct JensonFilePreview: View {
    /// The theme the preview should use. Defaults to Manuscript.
    @AppStorage("preview-theme") private var theme = PreviewThemeSelection.manuscript

    /// Whether the preview should take the full width of the window. Defaults to false.
    @AppStorage("use-full-width") private var fullWidth = false

    /// A binding to the currently open document.
    @Binding var document: JensonDocument

    var body: some View {
        Group {
            List {
                ForEach(document.timeline, id: \.self) { event in
                    JensonCellView(event: event)
                        .textSelection(.enabled)
                        .foregroundColor(theme.theme.textColor)
                        .font(theme.theme.fontStyle)
                        .listRowBackground(projectedBackground)
                }
            }
            .background(projectedBackground)
            .listStyle(.inset)
            .frame(maxWidth: fullWidth ? .infinity : 960)
            .introspectTableView { table in
                if let background = theme.theme.backgroundColor {
                    table.backgroundColor = NSColor(background)
                } else {
                    table.backgroundColor = NSColor.controlBackgroundColor
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var projectedBackground: some View {
        Group {
            if let background = theme.theme.backgroundColor {
                Rectangle()
                    .fill(background)
                    .shadow(radius: 10)
            } else {
                Rectangle()
                    .fill(.background)
                    .shadow(radius: 10)
            }
        }
    }
}

struct JensonFormattedView_Previews: PreviewProvider {
    static var previews: some View {
        JensonFilePreview(document: .constant(JensonDocument()))
    }
}
