//
//  AttributedStringViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2022/01/02.
//

import UIKit

protocol MyTextViewDelegate {
    func setStringToTextView(string: NSMutableAttributedString)
}

class AttributedStringViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    private var bool: Bool = false
    
    private var stringAttributes: [NSAttributedString.Key : Any] = [:]
    
    override func viewDidLoad() {
        textView.delegate = self
        AttributedStringSingleton.shared.setDelegate(delegate: self)
    }
    
    @IBAction func headlineFirstButton(_ sender: UIButton) {
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.font: UIFont.preferredFont(forTextStyle: .title1)])
    }
    
    @IBAction func headlineSecondButton(_ sender: UIButton) {
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.font: UIFont.preferredFont(forTextStyle: .title2)])
    }
    
    
    @IBAction func headlineThirdButton(_ sender: UIButton) {
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.font: UIFont.preferredFont(forTextStyle: .title3)])
    }
    
    @IBAction func plainTextButton(_ sender: UIButton) {
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.font: UIFont.preferredFont(forTextStyle: .body)])
    }
    
    @IBAction func boldButton(_ sender: UIButton) {
        ///方法１
        /** textView.font = UIFont.boldSystemFont(ofSize: textView.font!.pointSize) */
 
        ///方法２
        /** let stm = SymbolicTraitsModifer(font: textView.font!).bold()
        textView.font = stm.build() */
        
        ///方法３
        let stm = SymbolicTraitsModifer(font: textView.font!).bold()
        let string = NSMutableAttributedString(string: textView.text)
        string.addAttribute(.font, value: stm.build(), range: .init(location: 0, length: textView.text.count))
        textView.attributedText = string
    }
    
    
    @IBAction func italicButton(_ sender: UIButton) {
        ///方法１
        /** textView.font = UIFont.italicSystemFont(ofSize: textView.font!.pointSize) */
        
        ///方法２
        /** let stm = SymbolicTraitsModifer(font: textView.font!).italic()
        textView.font = stm.build() */
        
        ///方法３
//        let string = NSMutableAttributedString(string: textView.text)
//        let stm = SymbolicTraitsModifer(font: textView.font!).italic()
//        string.addAttribute(.font, value: stm.build(), range: .init(location: 0, length: textView.text.count))
        
        print(        textView.attributedText.enumerateAttribute(.font, in: NSRange(location: 1, length: 4)) { result, resultRange, _ in
            print(result)
            print(resultRange)})
    }
    
    @IBAction func underlineButton(_ sender: UIButton) {
        ///方法１
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.underlineStyle : 1])
    }
    
    @IBAction func strikeThroughButton(_ sender: UIButton) {
        let string = NSMutableAttributedString(string: textView.text)
        
        ///方法１
        string.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, 10))
        textView.attributedText = string
    }
    
    @IBAction func colorButton(_ sender: UIButton) {
        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: [.foregroundColor : UIColor.red])
    }
    
    func getCurrentLine() -> String {
        let allText = textView.text! as NSString
        let currentLine = allText.substring(with: allText.lineRange(for: textView.selectedRange))
        return currentLine
    }
}

//final class SymbolicTraitsModifer {
//    private let font: UIFont
//    private var traits: UIFontDescriptor.SymbolicTraits = []
//
//    init(font: UIFont) {
//        self.font = font
//        traits = font.fontDescriptor.symbolicTraits
//    }
//
//    func bold() -> SymbolicTraitsModifer {
//        traits.insert(.traitBold)
//        return self
//    }
//
//    func italic() -> SymbolicTraitsModifer {
//        traits.insert(.traitItalic)
//        return self
//    }
//
//    func build() -> UIFont {
//        if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
//            return UIFont(descriptor: descriptor, size: font.pointSize)
//        } else {
//            return font
//        }
//    }
//}

extension AttributedStringViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        let location = textView.selectedRange.location
        let length = textView.selectedRange.length
        if length <= 0 {
            return
        } else {
            let strIndex = textView.text.startIndex
            guard let startIndex = textView.text.index(strIndex, offsetBy: location, limitedBy: textView.text.endIndex),
                      let endIndex = textView.text.index(strIndex, offsetBy: location+length-1, limitedBy: textView.text.endIndex) else {
                return
            }
            let attributeString = textView.attributedText!
            AttributedStringSingleton.shared.setString(text: NSMutableAttributedString(attributedString: attributeString))
            AttributedStringSingleton.shared.setIndex(firstIndex: startIndex, LastIndex: endIndex)
        }
    }
}

extension AttributedStringViewController: MyTextViewDelegate {
    func setStringToTextView(string: NSMutableAttributedString) {
        textView.attributedText = string
    }
}
