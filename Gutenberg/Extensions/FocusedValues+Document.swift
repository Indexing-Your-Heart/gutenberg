//
//  FocusedValues+Document.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/17/22.
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
