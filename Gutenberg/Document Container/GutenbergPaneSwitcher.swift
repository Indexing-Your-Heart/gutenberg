//
//  PaneSwitcher.swift
//  Created by Marquis Kurt on 12/1/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergPaneSwitcher: View {
    @Binding var currentPane: JensonViewerPane

    @State var disabled: Bool = false

    var body: some View {
        Group {
#if targetEnvironment(macCatalyst)
            Picker("Pane", selection: $currentPane) {
                ForEach(JensonViewerPane.allCases, id: \.hashValue) { paneCase in
                    Text(paneCase.rawValue)
                        .tag(paneCase)
                }
            }
            .disabled(disabled)
#else
            Group {
                if currentPane == .preview {
                    Button {
                        withAnimation {
                            currentPane = .source
                        }
                    } label: {
                        Text("Edit")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                    }
                    .disabled(disabled)
                    .textCase(.uppercase)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                } else {
                    Button {
                        withAnimation {
                            currentPane = .preview
                        }
                    } label: {
                        Image(systemName: "doc.badge.ellipsis")
                    }
                    .disabled(disabled)
                }
            }
#endif
        }
    }
}
