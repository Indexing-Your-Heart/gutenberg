//
//  PaddedHStack.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
//

import Foundation
import SwiftUI

/// A view that creates a horizontal stack with padding on both sides.
struct PaddedHStack<PaddedContent: View>: View {
    /// The horizontal stack's alignment.
    var alignment: VerticalAlignment = .center

    /// The spacing between elements in the horizontal stack.
    var spacing: CGFloat?

    /// The content that will be padded.
    var content: () -> PaddedContent

    var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            Spacer()
            content()
            Spacer()
        }
    }
}
