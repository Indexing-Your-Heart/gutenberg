//
//  JensonFileValidator.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import CodeEditorView
import Foundation

/// A class responsible for validating a Jenson document.
class JensonFileValidator {
    /// The document that will be validated.
    var document: JensonDocument

    /// A set of errors, warnings, and other messages during validation.
    var validationMessages = Set<Located<Message>>()

    init(document: JensonDocument) {
        self.document = document
    }

    private var lines: [String] {
        document.jsonRepresentation.split(separator: "\n").map { String($0) }
    }
}

extension JensonFileValidator: FileValidator {
    /// Validates the open document and verifies that the format is correct.
    func validate() {
        var messages = Set<Located<Message>>()
        if document.version == 1 {
            messages = validateForV1()
            validationMessages.formUnion(messages)
            return
        }
        if document.content.story != nil {
            validationMessages.formUnion(messages)
            return
        }
        messages.insert(
            makeMessage(
                at: 1,
                category: .error,
                message: "Missing story metadata declaration",
                description: "Story metadata is required for for Jenson files v2 or later."
            )
        )
        validationMessages.formUnion(messages)
    }

    private func validateForV1() -> Set<Located<Message>> {
        var messages = Set<Located<Message>>()
        if document.content.story != nil {
            guard let idx = lines.firstIndex(where: { string in
                string.range(of: #"^\s+\"story\"\s+\:\s\{$"#, options: .regularExpression) != nil
            }) else {
                return messages
            }

            messages.insert(
                makeMessage(
                    at: idx + 1,
                    category: .error,
                    message: "Invalid declaration of story",
                    description: "Story metadata is only available for Jenson files v2 or later."
                )
            )
        }

        if document.content.application != nil {
            guard let idx = lines.firstIndex(where: { string in
                string.range(of: #"^\s+\"application\"\s+\:\s\{$"#, options: .regularExpression) != nil
            }) else {
                return messages
            }
            messages.insert(
                makeMessage(
                    at: idx + 1,
                    category: .error,
                    message: "Invalid declaration of application",
                    description: "Application metadata is only available for Jenson files v2 or later."
                )
            )
        }

        let errors = messages.filter { $0.entity.category == .error }
        if !errors.isEmpty {
            guard let idx = lines.firstIndex(where: { string in
                string.range(of: #"^\s+\"version\"\s+\:\s\d$"#, options: .regularExpression) != nil
            }) else {
                return messages
            }
            messages.insert(
                makeMessage(
                    at: idx + 1,
                    category: .warning,
                    message: "This manifest version doesn't support story or app medata objects.",
                    description: "Did you mean to specify a manifest v2 here?"
                )
            )
        }
        return messages
    }

    private func makeMessage(
        at row: Int,
        category: Message.Category,
        message: String,
        description: String
    ) -> Located<Message> {
        .init(
            location: .init(file: .init(), line: row, column: 0),
            entity: .init(category: category, length: 1, summary: message, description: .init(string: description))
        )
    }
}
