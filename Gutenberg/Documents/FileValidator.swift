//
//  FileValidator.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/16/22.
//

import CodeEditorView
import Foundation
import JensonKit

/// A protocol that indicates an object can handle validation of the Jenson format.
protocol FileValidator {
    /// A set of errors, warnings, and other messages during validation.
    /// This should be used to render the information in the source view.
    var validationMessages: Set<Located<Message>> { get set }

    /// Validates the open document and verifies that the format is correct.
    func validate()
}
