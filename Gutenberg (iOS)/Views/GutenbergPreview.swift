//
//  GutenbergPreview.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Introspect
import JensonKit
import SwiftUI
import UIKit

/// A view that shows a formatted view of a Jenson document.
struct GutenbergPreview: View {
    /// The window's current horizontal size class.
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    /// The user's preferred preview theme.
    @AppStorage("preview-theme") private var theme = PreviewThemeSelection.manuscript

    /// A binding to the document that will be previewed.
    @Binding var document: JensonDocument

    /// Whether the preview should take the full space of the device. Defaults to false.
    @State private var useFullWidth = false

    /// A list of timeline events.
    @State private var timeline: [JensonEvent] = []

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    projectedBackground
                    VStack(alignment: .leading) {
                        ForEach(timeline) { event in
                            JensonCellView(event: event)
                                .foregroundColor(theme.theme.textColor)
                                .font(theme.theme.fontStyle)
                                .padding(10)
                        }
                    }
                    .padding(.top)
                    .frame(
                        maxWidth: useFullWidth || horizontalSizeClass == .compact ? .infinity : proxy.size.width * 0.75
                    )
                }
            }
        }
        .background(projectedBackground.edgesIgnoringSafeArea(.all))
        .animation(.easeInOut, value: theme)
        .animation(.easeInOut, value: useFullWidth)
        .onAppear {
            let file = document.updateRepresentationToContents() ?? document.content
            timeline = file.timeline
        }
        .toolbar {
            ToolbarItem(id: "theme", placement: .secondaryAction) {
                Menu {
                    JensonThemePicker()
                } label: {
                    Label("Preview Theme", systemImage: "swatchpalette")
                }
            }
            ToolbarItem(id: "fullwidth", placement: .secondaryAction) {
                Toggle(isOn: $useFullWidth) {
                    Label("Fill Available Space", systemImage: "arrow.left.and.right.square")
                }
                .disabled(horizontalSizeClass == .compact)
            }
        }
        .toolbarRole(.editor)
    }

    private var projectedBackground: some View {
        Group {
            if let background = theme.theme.backgroundColor {
                Rectangle()
                    .fill(background)
            } else {
                Rectangle()
                    .fill(.background)
            }
        }
    }
}
