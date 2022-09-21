//
//  FileValidator.swift
//  Created by Marquis Kurt on 9/16/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
