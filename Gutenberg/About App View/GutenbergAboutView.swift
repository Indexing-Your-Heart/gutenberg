//
//  GutenbergAboutView.swift
//  Created by Marquis Kurt on 9/20/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

/// A view that displays the about window.
struct GutenbergAboutView: View {
    /// The environment's dismiss action to dismiss this sheet.
    @Environment(\.dismiss) private var dismissAction

    /// The current year.
    private var currentYear: String {
        Date.now.formatted(.dateTime.year())
    }

    var body: some View {
        VStack {
            ViewThatFits {
                regularHeader
                compactHeader
            }
            VStack(spacing: 0) {
                Divider()
                MarkdownReader(resourceNamed: "Credits")
                    .background(.background)
            }
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .toolbar {
            Button {
                dismissAction()
            } label: {
                Text("Done")
            }
        }
    }

    private var compactHeader: some View {
        VStack(spacing: 8) {
            VStack {
                Image("AppIconImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84)
                    .cornerRadius(16)
                Text("Gutenberg")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Version \(UIApplication.shared.version ?? "0.0.0") (\(UIApplication.shared.build ?? "0"))")
            Text(UIApplication.shared.copyright ?? "&copy; \(currentYear) Marquis Kurt.")
                .foregroundColor(.secondary)
                .font(.footnote)
            linkBar
        }
        .padding()
    }

    private var regularHeader: some View {
        HStack(spacing: 32) {
            Image("AppIconImage")
                .resizable()
                .scaledToFit()
                .frame(width: 128)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8) {
                Text("Gutenberg")
                    .font(.largeTitle)
                    .bold()
                Text("Version \(UIApplication.shared.version ?? "0.0.0") (\(UIApplication.shared.build ?? "0"))")
                linkBar
                Spacer()
                Text(UIApplication.shared.copyright ?? "&copy; \(currentYear) Marquis Kurt.")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom)
        .frame(maxHeight: 156)
    }

    private var linkBar: some View {
        HStack {
            Link(destination: URL(string: "https://github.com/Indexing-Your-Heart/gutenberg")!) {
                Label("Source Code", systemImage: "curlybraces.square")
            }
        }
    }
}
