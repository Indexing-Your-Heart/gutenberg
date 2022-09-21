//
//  JensonChoiceGroup.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation
import JensonKit
import SwiftUI

/// A view that displays a choice a player can make in a question menu.
struct JensonChoiceGroup: View {
    /// The choice that the player can make.
    @State var choice: JensonChoice

    var body: some View {
        Group {
            Text("**OPTION**: \(choice.name)")
            ForEach(choice.events, id: \.self) { event in
                JensonCellView(event: event)
            }
        }
        .padding(.horizontal, 24)
    }
}
