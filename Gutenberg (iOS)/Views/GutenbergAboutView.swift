//
//  GutenbergAboutView.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/20/22.
//

import SwiftUI

/// A view that displays the about window.
struct GutenbergAboutView: View {
    /// The environment's dismiss action to dismiss this sheet.
    @Environment(\.dismiss) var dismissAction

    /// The contents of the credits file.
    @State private var creditsText = AttributedString(stringLiteral: "No credits found.")

    /// The current year.
    private var currentYear: String {
        Date.now.formatted(.dateTime.year())
    }

    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Image("AppIconImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 76)
                    .cornerRadius(16)
                Text("Gutenberg for iOS")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Version \(UIApplication.shared.version ?? "0.0.0") (\(UIApplication.shared.build ?? "0"))")
            Text(UIApplication.shared.copyright ?? "&copy; \(currentYear) Marquis Kurt.")
                .foregroundColor(.secondary)
                .font(.footnote)
            ScrollView {
                Text(creditsText)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .toolbar {
            Button {
                dismissAction()
            } label: {
                Text("Done")
            }
        }
        .onAppear {
            getCredits()
        }
    }

    private func getCredits() {
        guard let path = Bundle.main.path(forResource: "Credits", ofType: "md") else { return }
        if let str = try? AttributedString(
            contentsOf: URL(filePath: path),
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            creditsText = str
        }
    }
}
