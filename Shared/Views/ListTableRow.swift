//
//  ListTableRow.swift
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
