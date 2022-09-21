//
//  JesonDocumentPropertiesView.swift
//  Created by Marquis Kurt on 9/9/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import JensonKit
import SwiftUI

/// A view that displays metadata information about the open document.
struct JensonDocumentPropertiesView: View {
    /// A binding to the currently open document.
    @Binding var document: JensonDocument

#if os(macOS)
    /// A focused binding to the currently available file validator.
    @FocusedBinding(\.validator) var validator
#endif

    var body: some View {
        List {
            storySection
            Section {
                applicationSection
                validationSection
            }
            statsSection
        }
#if os(macOS)
        .frame(width: 300)
#endif
    }

    private var storySection: some View {
        Group {
            if let story = document.story {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(story.name)
                            .font(.title)
                            .bold()
                        if let chapter = story.chapter {
                            Text(chapter)
                                .font(.title3)
                                .bold()
                        }
                        Text(story.author)
                        if let copyright = story.copyright {
                            Text(copyright)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }

    private var applicationSection: some View {
        Group {
            if let application = document.application {
                ListTableRow {
                    Text("Application")
                } value: {
                    Group {
                        if let link = application.website, let url = URL(string: link) {
                            Link(destination: url) {
                                Label(application.name, systemImage: "link")
                            }
                        } else {
                            Text(application.name)
                        }
                    }
                }
            }
        }
    }

    private var statsSection: some View {
        Section {
            ListTableRow {
                Text("Total Events")
            } value: {
                Text(document.timeline.count, format: .number)
                    .font(.body.monospaced())
            }
            ForEach(JensonEvent.EventType.allCases, id: \.hashValue) { eventType in
                ListTableRow {
                    Text(eventType.rawValue.capitalized + " Events")
                } value: {
                    Text(count(of: eventType), format: .number)
                        .font(.body.monospaced())
                }
            }
        } header: {
            Text("Statistics")
        }
    }

    private var validationSection: some View {
        Group {
            ListTableRow {
                Text("Manifest Version")
            } value: {
                Text(document.version, format: .number)
                    .font(.body.monospaced())
                    .foregroundColor(.secondary)
            }
#if os(macOS)
            if validator?.validationMessages.isEmpty == true {
                Label {
                    Text("This manifest is valid.")
                } icon: {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                }
                .font(.subheadline.bold())
            } else {
                Label {
                    Text("This manifest is invalid.")
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.yellow)
                }
                .font(.subheadline.bold())
                Text("This Jenson file's manifest is invalid. Check the source view for any potential problems.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .listRowBackground(Color.clear)
            }
#endif
            if document.readDecompressedFile {
                Label {
                    Text("This file is uncompressed.")
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.yellow)
                }
                .font(.subheadline.bold())
            }
        }
    }

    private func count(of type: JensonEvent.EventType) -> Int {
        document.timeline.filter { $0.type == type }.count
    }
}

struct JesonDocumentPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        JensonDocumentPropertiesView(document: .constant(JensonDocument()))
    }
}
