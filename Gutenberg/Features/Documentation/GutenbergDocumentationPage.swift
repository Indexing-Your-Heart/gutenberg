//
//  DocumentationPage.swift
//  Created by Marquis Kurt on 4/15/23.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation

enum GutenbergDocumentationPage: String {
    case manifestOverview = "ManifestOverview"
    case storyMetadata = "StoryMetadata"
    case events = "Events"
    case questions = "AskingQuestions"
    case refresh = "RefreshScene"

    var title: String {
        switch self {
        case .manifestOverview:
            return "The Jenson Manifest"
        case .storyMetadata:
            return "Story Metadata"
        case .events:
            return "Events"
        case .questions:
            return "Asking Questions"
        case .refresh:
            return "Refreshing the Scene"
        }
    }
}

extension GutenbergDocumentationPage: CaseIterable {}
extension GutenbergDocumentationPage: Identifiable {
    var id: String { self.rawValue }
}
