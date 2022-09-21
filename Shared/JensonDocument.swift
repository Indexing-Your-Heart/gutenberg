//
//  Jenson_VisualizerDocument.swift
//  Created by Marquis Kurt on 9/8/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Compression
import JensonKit
import SwiftUI
import UniformTypeIdentifiers

/// A struct that represents an open Jenson document container.
struct JensonDocument: FileDocument {
    /// The associated file types this document will be able to read.
    static var readableContentTypes: [UTType] { [.jenson] }

    /// The associated file types this document will be able to write.
    static var writableContentTypes: [UTType] { [.jenson] }

    /// The application that authored the file.
    /// - SeeAlso: ``JensonKit.JensonApp``.
    var application: JensonApp? { content.application }

    /// The contents of the Jenson document.
    var content: JensonFile

    /// The internal JSON representation of the Jenson document.
    var jsonRepresentation: String = ""

    /// Whether the document that was read was uncompressed.
    var readDecompressedFile: Bool { _readDecompressedFile }

    /// The story metadata of the Jenson document.
    var story: JensonStory? { content.story }

    /// The list of events in the Jenson document.
    var timeline: [JensonEvent] { content.timeline }

    /// The Jenson document's manifest version.
    var version: Int { content.version }

    private var _readDecompressedFile = false

    init(contentsOf content: JensonFile = .template) {
        self.content = content
        getStringRepresentation()
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let reader = JensonReader(data)
        do {
            content = try reader.decode()
            _readDecompressedFile = false
        } catch let error where error is DecodingError { throw error }
        catch {
            reader.compressed = false
            content = try reader.decode()
            _readDecompressedFile = true
        }
        getStringRepresentation()
    }

    func fileWrapper(configuration _: WriteConfiguration) throws -> FileWrapper {
        guard let newContent = updateRepresentationToContents() else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let writer = JensonWriter(contentsOf: newContent)
        let originalData = try writer.data()
        let data = originalData.base64EncodedString(options: .lineLength64Characters).data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }

    private mutating func getStringRepresentation() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        if let encoded = try? encoder.encode(content), let strRep = String(data: encoded, encoding: .utf8) {
            jsonRepresentation = strRep
        }
    }

    /// Refreshes the file's contents to match the JSON structure.
    /// - Returns: An updated `JensonFile` reflecting the changes, or `nil` if the decoding failed.
    func updateRepresentationToContents() -> JensonFile? {
        guard let data = jsonRepresentation.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(JensonFile.self, from: data)
    }
}

extension UTType {
    /// Represents the Jenson file type.
    static var jenson: UTType {
        UTType(importedAs: "art.indexingyourhe.jenson")
    }
}
