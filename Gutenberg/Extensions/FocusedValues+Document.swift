//
//  FocusedValues+Document.swift
//  Created by Marquis Kurt on 9/17/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

extension FocusedValues {
    /// A struct that represents a Jenson document.
    struct DocumentFocusedValues: FocusedValueKey {
        typealias Value = Binding<JensonDocument>
    }

    /// A struct that represents a file validator.
    struct ValidatorFocusedValues: FocusedValueKey {
        typealias Value = Binding<FileValidator>
    }

    /// The currently focused document.
    var document: Binding<JensonDocument>? {
        get { self[DocumentFocusedValues.self] }
        set { self[DocumentFocusedValues.self] = newValue }
    }

    /// The currently focused validator.
    var validator: Binding<FileValidator>? {
        get { self[ValidatorFocusedValues.self] }
        set { self[ValidatorFocusedValues.self] = newValue }
    }
}
