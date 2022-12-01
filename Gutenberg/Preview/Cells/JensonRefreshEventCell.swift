//
//  JensonRefreshEventCell.swift
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

/// A view that displays a refresh event.
struct JensonRefreshEventCell: View {
    /// The event to render into the cell.
    var event: JensonEvent

    var body: some View {
        Group {
            if let refresh = event.refresh {
                if refresh.isEmpty {
                    PaddedHStack {
                        Label(
                            "Refresh declared here, but no triggers present",
                            systemImage: "exclamationmark.triangle"
                        )
                        .foregroundColor(.yellow)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Refresh the following: ", systemImage: "arrow.triangle.2.circlepath")
                            .foregroundColor(.indigo)
                        ForEach(refresh) { refresh in
                            refreshLabel(for: refresh)
                                .padding(.horizontal, 24)
                        }
                    }
                }
            } else {
                PaddedHStack {
                    Label("Refresh missing from refresh type", systemImage: "exclamationmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }

    private func label(for trigger: JensonRefreshContent) -> String {
        if trigger.resourceName.isEmpty {
            return "Clear **\(trigger.kind.rawValue)** at layer _\(trigger.priority ?? 0)_"
        }
        return "Update **\(trigger.kind.rawValue)** at layer _\(trigger.priority ?? 0)_ to '\(trigger.resourceName)'"
    }

    private func refreshLabel(for trigger: JensonRefreshContent) -> some View {
        Label {
            Text(label(for: trigger).attributed())
        } icon: {
            Group {
                switch trigger.kind {
                case .image:
                    Image(systemName: "photo")
                case .soundEffect:
                    Image(systemName: "speaker.wave.3")
                case .music:
                    Image(systemName: "music.note")
                default:
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            .symbolRenderingMode(.multicolor)
            .tint(.indigo)
        }
    }
}
