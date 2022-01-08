//
//  AttributedStringViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2022/01/02.
//

import UIKit

class AttributedStringViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    private var bool: Bool = false
    
    private var stringAttributes: [NSAttributedString.Key : Any] = [:]
    
    override func viewDidLoad() {
        textView.delegate = self
    }
    
    @IBAction func headlineFirstButton(_ sender: UIButton) {
    }
    
    @IBAction func headlineSecondButton(_ sender: UIButton) {
    }
    
    
    @IBAction func headlineThirdButton(_ sender: UIButton) {
    }
    
    @IBAction func plainTextButton(_ sender: UIButton) {
    }
    
    @IBAction func boldButton(_ sender: UIButton) {
//        textView.font = UIFont.boldSystemFont(ofSize: textView.font!.pointSize)
        let stm = textView.font?.stm
        stm?.bold()
        textView.font = stm?.build()
    }
    
    
    @IBAction func italicButton(_ sender: UIButton) {
//        textView.font = UIFont.italicSystemFont(ofSize: textView.font!.pointSize)
        let stm = textView.font?.stm
        stm?.italic()
        textView.font = stm?.build()
    }
    
    @IBAction func underlineButton(_ sender: UIButton) {
    }
    
    @IBAction func strikeThroughButton(_ sender: UIButton) {
    }
    
    @IBAction func bulletedListButton(_ sender: UIButton) {
        
    }
    
    @IBAction func numberedListButton(_ sender: UIButton) {
        
    }
    
    @IBAction func checkListButton(_ sender: UIButton) {
    }
    
    func getCurrentLine() -> String {
        let allText = textView.text! as NSString
        let currentLine = allText.substring(with: allText.lineRange(for: textView.selectedRange))
        return currentLine
    }
}

final class SymbolicTraitsModifer {
    private let font: UIFont
    private var traits: UIFontDescriptor.SymbolicTraits = []

    init(font: UIFont) {
        self.font = font
        traits = font.fontDescriptor.symbolicTraits
    }

    func bold() -> SymbolicTraitsModifer {
        traits.insert(.traitBold)
        return self
    }

    func italic() -> SymbolicTraitsModifer {
        traits.insert(.traitItalic)
        return self
    }

    func build() -> UIFont {
        if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: font.pointSize)
        } else {
            return font
        }
    }
}

extension UIFont {
    
    var stm: SymbolicTraitsModifer {
        SymbolicTraitsModifer(font: self)
    }

    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {

        // create a new font descriptor with the given traits
        guard let fd = fontDescriptor.withSymbolicTraits(traits) else {
            // the given traits couldn't be applied, return self
            return self
        }

        // return a new font with the created font descriptor
        return UIFont(descriptor: fd, size: pointSize)
    }

    func italics() -> UIFont {
        return withTraits(.traitItalic)
    }

    func bold() -> UIFont {
        return withTraits(.traitBold)
    }

    func boldItalics() -> UIFont {
        return withTraits([ .traitBold, .traitItalic ])
    }
}

extension AttributedStringViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
}
