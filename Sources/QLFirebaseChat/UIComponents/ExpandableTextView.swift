//
//  ExpandableTextView.swift
//  FirebaseChatExample
//
//  Created by Abhishek Pandey on 25/09/23.
//

import SwiftUI
import UIKit

struct ExpandableTextView: UIViewRepresentable {
    @Binding var text: String
    var foregroundColor = Color.black
    var backgroundColor = Color.clear
    var lineNumberCallback: ((Int) -> Void)?

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.backgroundColor = UIColor(backgroundColor)
        textView.textColor = UIColor(foregroundColor)
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
        textView.textContainer.maximumNumberOfLines = .max
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context _: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ExpandableTextView

        init(_ parent: ExpandableTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            expandTextView(textView: textView)
            // expandTextView(textView)
        }

        func expandTextView(textView: UITextView) {
            let maxLines = 5
            let numLines = textView.numberOfLines()

            textView.isScrollEnabled = true
            if Int(numLines) >= maxLines {
                parent.lineNumberCallback?(4)
            } else {
                parent.lineNumberCallback?(numLines)
            }
            parent.text = textView.text
        }
    }
}
