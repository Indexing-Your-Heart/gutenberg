//
//  JensonDocument+Transferable.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/19/22.
//

import JensonKit
import SwiftUI

extension JensonDocument: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .jenson) { file in
            let writer = JensonWriter(contentsOf: file.content)
            do { return try writer.data() }
            catch { return Data() }
        } importing: { data in
            let reader = JensonReader(data)
            let file = (try? reader.decode()) ?? JensonFile.template
            return JensonDocument(contentsOf: file)
        }
    }
}
