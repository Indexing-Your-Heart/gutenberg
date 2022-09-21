//
//  JensonChoiceGroup.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/19/22.
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
