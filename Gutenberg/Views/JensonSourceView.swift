//
//  JensonSourceView.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/9/22.
//

import CodeEditorView
import SwiftUI

/// A view that allows users to view and edit the source contents of the Jenson document.
struct JensonSourceView: View {
    /// A binding to the currently open document.
    @Binding var document: JensonDocument

    /// A focused binding to the currently available file validator.
    @FocusedBinding(\.validator) var validator: FileValidator?

    /// The current color scheme the user has on the system.
    @Environment(\.colorScheme) var colorScheme

    /// The current editor position.
    @State private var editorPosition = CodeEditor.Position()

    /// A set of messages to display in the source view.
    @State private var messages = Set<Located<Message>>()

    /// Whether a validation check is in progress.
    @State private var validating = false

    /// A timer that automatically validates the file every ten seconds.
    private let validationTimer = Timer.publish(every: 10, on: .current, in: .common).autoconnect()

    /// An array that includes the file's JSON contents, split by line.
    private var lines: [String] {
        document.jsonRepresentation.split(separator: "\n").map { String($0) }
    }

    /// A filtered array of messages that only contain warnings.
    private var warnings: [Located<Message>] {
        messages.filter { $0.entity.category == .warning }
    }

    /// A filtered array of messages that only contain errors.
    private var errors: [Located<Message>] {
        messages.filter { $0.entity.category == .error }
    }

    var body: some View {
        VStack(spacing: 0) {
            CodeEditor(
                text: $document.jsonRepresentation,
                position: $editorPosition,
                messages: $messages,
                language: .swift,
                layout: .standard
            )
            .environment(\.codeEditorTheme, colorScheme == .dark ? Theme.defaultDark : Theme.defaultLight)
            statusBar
        }
        .onAppear {
            withAnimation {
                validating = true
                if let msgs = validator?.validationMessages {
                    messages = msgs
                }
                validating = false
            }
        }
        .onReceive(validationTimer) { _ in
            withAnimation {
                validating = true
                validator?.validate()
                if let msgs = validator?.validationMessages {
                    messages = msgs
                }
                validating = false
            }
        }
    }

    private var statusBar: some View {
        HStack {
            Text("\(lines.count) Lines")
                .bold()
            Spacer()
            if validating {
                HStack(spacing: 8) {
                    Text("Validating...")
                    ProgressView()
                        .controlSize(.small)
                    Divider()
                        .frame(maxHeight: 16)
                }
                .padding(.horizontal, 4)
            }
            Label {
                Text(errors.count, format: .number)
            } icon: {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
            }
            .font(.body.bold())
            .labelStyle(.titleAndIcon)

            Label {
                Text(warnings.count, format: .number)
            } icon: {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.yellow)
            }
            .font(.body.bold())
            .labelStyle(.titleAndIcon)
        }
        .foregroundColor(.secondary)
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(.background)
        .border(.separator)
    }
}

struct JensonSourceView_Previews: PreviewProvider {
    static var previews: some View {
        JensonSourceView(document: .constant(.init()))
    }
}
