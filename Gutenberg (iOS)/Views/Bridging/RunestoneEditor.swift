//
//  RunestoneView.swift
//  Gutenberg (iOS)
//
//  Created by Marquis Kurt on 9/19/22.
//

import Foundation
import Runestone
import SwiftUI
import TreeSitterJSONRunestone

/// A view that lets users view and edit source code using the Runestone text view.
struct RunestoneEditor: UIViewRepresentable {
    typealias UIViewType = Runestone.TextView

    enum FindInteractionStyle {
        case disabled
        case find
        case replace
    }

    /// The text that the Runestone editor will be able to manipulate.
    var text: Binding<String>
    private var showLineNumbers: Bool = false
    private var lineSpacing: CGFloat = 1.0
    private var fontSize: CGFloat = 13.0
    private var lineWrapping: Bool = true
    private var findInteraction: FindInteractionStyle = .disabled

    init(text: Binding<String>) {
        self.text = text
        showLineNumbers = false
        lineSpacing = 1.0
        lineWrapping = true
        findInteraction = .disabled
    }

    fileprivate init(
        text: Binding<String>,
        showLineNumbers: Bool = false,
        lineSpacing: CGFloat = 1.0,
        fontSize: CGFloat = 13.0,
        lineWrapping: Bool = true,
        findInteraction: FindInteractionStyle = .disabled
    ) {
        self.text = text
        self.showLineNumbers = showLineNumbers
        self.lineSpacing = lineSpacing
        self.fontSize = fontSize
        self.lineWrapping = lineWrapping
        self.findInteraction = findInteraction
    }

    func makeCoordinator() -> Coordinator {
        .init(view: self)
    }

    func makeUIView(context: Context) -> UIViewType {
        let textEditorView = TextView.withDisabledAutocorrect()
        textEditorView.editorDelegate = context.coordinator.delegate
        textEditorView.backgroundColor = .systemBackground
        textEditorView.text = text.wrappedValue
        textEditorView.isFindInteractionEnabled = true
        setTextState(on: textEditorView)
        updateViewProperties(on: textEditorView)
        updateFindInteraction(on: textEditorView)
        return textEditorView
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        updateViewProperties(on: uiView)
        updateFindInteraction(on: uiView)
    }

    private func updateViewProperties(on uiView: UIViewType) {
        uiView.showLineNumbers = showLineNumbers
        uiView.lineHeightMultiplier = lineSpacing
        uiView.theme = ModifiedDefaultTheme(with: fontSize)
        uiView.isLineWrappingEnabled = lineWrapping
    }

    private func setTextState(on view: UIViewType) {
        DispatchQueue.global(qos: .userInitiated).async {
            let state = TextViewState(text: text.wrappedValue, language: .json)
            DispatchQueue.main.async {
                view.setState(state)
            }
        }
    }

    private func updateFindInteraction(on view: UIViewType) {
        if findInteraction != .disabled {
            view.findInteraction?.presentFindNavigator(showingReplace: findInteraction == .replace)
        } else {
            view.findInteraction?.dismissFindNavigator()
        }
    }
}

extension RunestoneEditor {
    /// The coordinator responsible for handling Runestone text events.
    final class Coordinator {
        private var view: RunestoneEditor
        fileprivate var delegate: RunestoneViewDelegate

        init(view: RunestoneEditor) {
            self.view = view
            delegate = RunestoneViewDelegate(text: view.text)
        }
    }

    /// Sets whether the line numbers are visible.
    func showLineNumbers(_ numbers: Bool = true) -> Self {
        .init(
            text: text,
            showLineNumbers: numbers,
            lineSpacing: lineSpacing,
            fontSize: fontSize,
            lineWrapping: lineWrapping
        )
    }

    /// Sets the spacing between lines.
    func lineSpacing(_ lineSpacing: CGFloat) -> Self {
        .init(
            text: text,
            showLineNumbers: showLineNumbers,
            lineSpacing: lineSpacing,
            fontSize: fontSize,
            lineWrapping: lineWrapping
        )
    }

    /// Sets the text editor font size.
    func fontSize(_ size: CGFloat) -> Self {
        .init(
            text: text,
            showLineNumbers: showLineNumbers,
            lineSpacing: lineSpacing,
            fontSize: size,
            lineWrapping: lineWrapping
        )
    }

    /// Sets whether the lines will wrap around the edges of the view.
    func lineWrapping(_ wrapped: Bool) -> Self {
        .init(
            text: text,
            showLineNumbers: showLineNumbers,
            lineSpacing: lineSpacing,
            fontSize: fontSize,
            lineWrapping: wrapped
        )
    }

    func findNavigator(presentationStyle: Binding<FindInteractionStyle>) -> Self {
        .init(
            text: text,
            showLineNumbers: showLineNumbers,
            lineSpacing: lineSpacing,
            fontSize: fontSize,
            lineWrapping: lineWrapping,
            findInteraction: presentationStyle.wrappedValue
        )
    }
}
