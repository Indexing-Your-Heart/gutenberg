//
//  AnimatedButton.swift
//  Created by Marquis Kurt on 12/6/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct AnimatedButton<Title: View, Icon: View>: View {
    var animation: Animation?
    var action: () -> Void
    var label: () -> Label<Title, Icon>

    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            label()
        }
    }
}
