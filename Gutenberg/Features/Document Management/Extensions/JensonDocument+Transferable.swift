//
//  JensonDocument+Transferable.swift
//  Created by Marquis Kurt on 9/19/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import JensonKit
import SwiftUI

extension GutenbergDocument: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .jenson) { file in
            let writer = JensonWriter(contentsOf: file.content)
            do {
                return try writer.data()

            } catch {
                return Data()
            }
        } importing: { data in
            let reader = JensonReader(data)
            let file = (try? reader.decode()) ?? JensonFile.template
            return GutenbergDocument(contentsOf: file)
        }
    }
}
