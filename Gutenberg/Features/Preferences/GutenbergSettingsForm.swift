//
//  GutenbergSettingsForm.swift
//  Created by Marquis Kurt on 12/5/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergSettingsForm: View {
    /// The pane that should open by default. Defaults to the preview.
    @AppStorage("default-pane") private var preferredDefaultPane: JensonViewerPane = .source

    /// Whether to display an alert when a Markdown document was converted into Jenson. Defaults to true.
    @AppStorage("warn-markdown-convert") private var warnMarkdownConversion = true

    /// The default name to add to new documents.
    @AppStorage("new-document-name") private var newDocumentName = "Mobile User"

    var body: some View {
        Form {
            Section {
                Picker("When opening a document, display: ", selection: $preferredDefaultPane) {
                    ForEach(JensonViewerPane.allCases, id: \.hashValue) { paneCase in
                        Text(paneCase.rawValue).tag(paneCase)
                    }
                }
                Toggle(isOn: $warnMarkdownConversion) {
                    Text("Show warning when importing Markdown files")
                }
            }
            Section {
                ListTableRow {
                    Text("Author")
                } value: {
                    TextField("Mobile User", text: $newDocumentName)
                }
            } header: {
                Text("Source Editing")
            }
        }
        .navigationTitle("Settings")
    }
}

struct GutenbergSettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        GutenbergSettingsForm()
    }
}
