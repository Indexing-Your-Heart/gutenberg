//
//  ListTableRow.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
//

import Foundation
import SwiftUI

/// A view that creates a table-like row.
struct ListTableRow<KeyContent: View, ValueContent: View>: View {
    /// The table row's key, displayed on the left side.
    var key: () -> KeyContent

    /// The table's value key, displayed on the right side.
    var value: () -> ValueContent

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            key()
            Spacer()
            value()
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}
