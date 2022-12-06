//
//  JensonViewerPane.swift
//  Created by Marquis Kurt on 9/9/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation

/// An enumeration representing the various panes.
enum JensonViewerPane: String, CaseIterable {
    /// The source view, which shows the internal JSON.
    case source = "Source View"

    /// The formatted view.
    case preview = "Preview"

    /// The system image name associated with the pane.
    var systemImage: String {
        switch self {
        case .preview:
            return "eye"
        case .source:
            return "curlybraces.square"
        }
    }
}
