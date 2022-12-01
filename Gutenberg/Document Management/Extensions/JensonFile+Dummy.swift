//
//  JensonFile+Dummy.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
                .init(kind: .image, resourceName: "JohannesPortrait", priority: 2)
            ]),
            .init(type: .dialogue, who: "Johannes", what: "Open the Source View to make changes to the source!"),
            .init(
                type: .question,
                who: "",
                what: "",
                question: .init(
                    question: "What shall you do next?",
                    options: [
                        .init(
                            name: "Start writing",
                            events: [
                                .init(type: .comment, who: "", what: "A choice was made!")
                            ]
                        )
                    ]
                )
            )
        ]
    )
}
