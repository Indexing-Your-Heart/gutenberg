//
//  MarkdownReader.swift
//  Created by Marquis Kurt on 12/5/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct MarkdownReader: View {
    private var stringContents = ""

    init(resourceNamed resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "md") {
            do {
                stringContents = try String(contentsOfFile: path)
            } catch {
                stringContents = "`Failed to load data.`"
            }
        }
    }

    var body: some View {
        ScrollView {
            Text(stringContents.attributed())
                .padding()
        }
    }
}
