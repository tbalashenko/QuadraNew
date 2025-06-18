//
//  TextView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 22/04/2024.
//

import SwiftUI

struct HighlightableTextView: View {
    @EnvironmentObject var settings: SettingsService
    @State private var dynamicHeight: CGFloat = 50
    @State private var showingPlaceholder = true
    @Binding var text: AttributedString
    let placeholder: String
    var error: String
    var pasteButtonAction: ((String) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UITextViewRepresentable(
                    text: $text,
                    palette: settings.highlighterPalette,
                    calculatedHeight: $dynamicHeight
                )
                .padding(.leading, SizeConstants.mediumSpacing)
                .padding(.trailing, SizeConstants.bigSpacing)
                .background(
                    Color.element
                        .shadow(.inner(color: .highlight, radius: 3, x: -3, y: -3))
                        .shadow(.inner(color: .shadow, radius: 3, x: 3, y: 3))
                )
                .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
                .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                .overlay(alignment: text.isEmpty ? .leading : .trailing) {
                    if text.isEmpty {
                        placeholderView
                    } else {
                        ClearButton(value: $text)
                    }
                }
                
                PasteButton { pasteButtonAction?($0) }
            }
            ErrorView(error: error)
        }
    }
    
    private var placeholderView: some View {
        Text(placeholder)
            .foregroundColor(Color.gray.opacity(0.5))
            .padding(.leading, 20)
    }
}

#Preview {
    @Previewable
    @State var text: AttributedString = ""
    
    HighlightableTextView(
        text: $text,
        placeholder: "Tessst",
        error: ""
    )
    .environmentObject(SettingsService())
}

private struct UITextViewRepresentable: UIViewRepresentable {
    @Binding var text: AttributedString
    @Binding var calculatedHeight: CGFloat
    let textView = HighlightableUITextView()
    let palette: HighlighterPalette
    
    init(text: Binding<AttributedString>, palette: HighlighterPalette, calculatedHeight: Binding<CGFloat>) {
        self._text = text
        self._calculatedHeight = calculatedHeight
        textView.palette = palette
        self.palette = palette
    }
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        textView.palette = palette
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = NSAttributedString(text)
        UITextViewRepresentable.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                withAnimation {
                    result.wrappedValue = newSize.height
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: AttributedString
        @Binding var calculatedHeight: CGFloat
        
        init(text: Binding<AttributedString>, height: Binding<CGFloat>) {
            self._text = text
            self._calculatedHeight = height
        }
        
        func textViewDidChange(_ textView: UITextView) {
            _text.wrappedValue = AttributedString(textView.attributedText)
            
            if let highlightableTV = textView as? HighlightableUITextView {
                highlightableTV.applyBaseAttributes()
            }
            
            UITextViewRepresentable.recalculateHeight(view: textView, result: $calculatedHeight)
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            _text.wrappedValue = AttributedString(textView.attributedText)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            
            if let pasteboardString = UIPasteboard.general.string, text == pasteboardString {
                let plainText = NSMutableAttributedString(attributedString: pasteboardString.attributedNs())
                
                let mutableAttributedText = NSMutableAttributedString(attributedString: textView.attributedText)
                
                mutableAttributedText.replaceCharacters(in: range, with: plainText)
                
                textView.attributedText = mutableAttributedText
                
                _text.wrappedValue = (try? AttributedString(mutableAttributedText, including: \.uiKit)) ?? AttributedString(mutableAttributedText.string)
                
                if let highlightableTV = textView as? HighlightableUITextView {
                    highlightableTV.applyBaseAttributes()
                }
                
                UITextViewRepresentable.recalculateHeight(view: textView, result: $calculatedHeight)
                
                return false
            }
            return true
        }
    }
}

private class HighlightableUITextView: UITextView {
    var palette: HighlighterPalette
    
    init(palette: HighlighterPalette = .pale) {
        self.palette = palette
        super.init(frame: .zero, textContainer: nil)
        self.backgroundColor = .clear
        self.isScrollEnabled = false
        self.autocorrectionType = .no
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.returnKeyType = .done
#warning("change when I will be doing something with font")
        self.font = .boldSystemFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyBaseAttributes() {
        guard let currentAttributedText = self.attributedText else { return }
        let mutable = NSMutableAttributedString(attributedString: currentAttributedText)
        let fullRange = NSRange(location: 0, length: mutable.length)
        
        mutable.enumerateAttributes(in: fullRange, options: []) { attrs, range, _ in
            var newAttrs = attrs
            
            if attrs[.font] == nil {
                newAttrs[.font] = UIFont.boldSystemFont(ofSize: 18)
            }
            
            if attrs[.foregroundColor] == nil {
                newAttrs[.foregroundColor] = UIColor.label
            }
            
            mutable.setAttributes(newAttrs, range: range)
        }
        
        let selectedRange = self.selectedRange
        self.attributedText = mutable
        self.selectedRange = selectedRange
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let actions: [Selector] = [
            #selector(UIResponderStandardEditActions.copy(_:)),
            #selector(UIResponderStandardEditActions.cut(_:)),
            #selector(UIResponderStandardEditActions.paste(_:))
        ]
        return actions.contains(action)
    }
    
    override func editMenu(for textRange: UITextRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        var actions: [UIMenuElement] = []
        
        let colorActions = palette.colors.map { color in
            let conf = UIImage.SymbolConfiguration(paletteColors: [color])
                .applying(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
            
            return UIAction(
                image: UIImage(named: "highlighter", in: nil, with: conf),
                handler: { [weak self] _ in
                    guard
                        let self = self,
                        let range = self.nsRange(from: textRange)
                    else { return }
                    
                    let updatedAttributes: [NSAttributedString.Key: Any] = [
                        .backgroundColor: color,
                        .font: UIFont.boldSystemFont(ofSize: 18)
                    ]
                    
                    self.textStorage.beginEditing()
                    self.textStorage.setAttributes(updatedAttributes, range: range)
                    self.textStorage.endEditing()
                    if let delegate {
                        delegate.textViewDidChange?(self)
                    }
                })
        }
        
        let clearAction = UIAction(title: "Clear Formatting") { [weak self] _ in
            guard
                let self = self,
                let range = self.nsRange(from: textRange)
            else { return }
            
            let updatedAttributes: [NSAttributedString.Key: Any] = [
                .backgroundColor: UIColor.clear,
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.black
            ]
            
            self.textStorage.beginEditing()
            self.textStorage.setAttributes(updatedAttributes, range: range)
            self.textStorage.endEditing()
            if let delegate {
                delegate.textViewDidChange?(self)
            }
        }
        
        actions += colorActions
        actions.append(clearAction)
        actions += suggestedActions
        
        return UIMenu(children: actions)
    }
}
