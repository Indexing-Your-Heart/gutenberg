//
//  JensonFile+Dummy.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/17/22.
//

import Foundation
import JensonKit

extension JensonFile {
    /// A template file used during new file creation.
    static var template = JensonFile(
        version: 2,
        application: .init(name: "Gutenberg"),
        story: .init(
            name: "Untitled Story",
            author: NSFullUserName(),
            copyright: "(C) \(Calendar.current.component(.year, from: .now)) \(NSFullUserName()). All rights reserved."
        ),
        timeline: [
            .init(type: .comment, who: "", what: "This is a comment.", question: nil),
            .init(type: .refresh, who: "", what: "", refresh: [
                .init(kind: .image, resourceName: "JohannesPortrait", priority: 2),
            ]),
            .init(type: .dialogue, who: "Johannes", what: "Open the Source View to make changes to the source!"),
        ]
    )
}
