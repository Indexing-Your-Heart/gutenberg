//
//  GutenbergDocumentationPageView.swift
//  Created by Marquis Kurt on 4/15/23.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import SwiftUI

struct GutenbergDocumentationPageView: View {
    var page: GutenbergDocumentationPage

    var body: some View {
        MarkdownReader(resourceNamed: page.rawValue)
            .navigationTitle(page.title)
    }
}
