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
    
    private var separatedStrings = [String]()
    
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
    }
    
    
    @IBAction func italicButton(_ sender: UIButton) {
    }
    
    @IBAction func underlineButton(_ sender: UIButton) {
    }
    
    @IBAction func strikeThroughButton(_ sender: UIButton) {
    }
    
    @IBAction func bulletedListButton(_ sender: UIButton) {
        guard let _ = textView.text else {
            return
        }
        
        // 句読点
        let bullet = "\u{2022}"
        
        // \nで文字列を分解
        separatedStrings = textView.text.components(separatedBy: "\n")
        separatedStrings = separatedStrings.map {
            return bullet + $0
        }
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
                attributes[.foregroundColor] = UIColor.darkGray
        
        // 文の先頭を句読点と同じ位置に揃える
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = bullet.size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        
        // joined(separator):文字要素間に要素を追加
        let bulletlistString = separatedStrings.joined(separator: "\n")
//        textView.attributedText = NSAttributedString(string: bulletlistString, attributes: attributes)
        textView.text = bulletlistString

        print(separatedStrings)
        print(bulletlistString)
        
    }
    
    @IBAction func numberedListButton(_ sender: UIButton) {
        
    }
    
    @IBAction func checkListButton(_ sender: UIButton) {
        print(getCurrentLine())
        let text = getCurrentLine()
        
        if let theRange = textView.text.range(of: "\n") {
            if textView.cursorIndex! < theRange.upperBound {
                let afterStr = textView.text[textView.cursorIndex!...theRange.upperBound]
                print(afterStr)
            } else {
                let afterStr = textView.text[theRange.lowerBound...textView.cursorIndex!]
                print(afterStr)
            }
        } else {
            print(textView.text)
        }
    }
    
    func getCurrentLine() -> String {
        let allText = textView.text! as NSString
        let currentLine = allText.substring(with: allText.lineRange(for: textView.selectedRange))
        return currentLine
    }
    
}

extension AttributedStringViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" && getCurrentLine().prefix(1) == "\u{2022}" && bool == true {
            textView.replace(textView.selectedTextRange!, withText: "\u{2022}")
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        bool = false
        textView.insertText(String(UnicodeScalar(8)))
    }
}

extension UITextView {
    
//    func getTextFromCursorToNewline(currentLineText: String) -> String? {
//        guard let currentRange = self.selectedTextRange else {
//            return nil
//        }
//
//        let currentPosition = currentRange.start
//        returj
//    }
    
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }
    
    var cursorIndex: String.Index? {
        guard let location = cursorOffset else { return nil }
        return Range(.init(location: location, length: 0), in: text)?.lowerBound
    }
    
    // カーソルの左、右の全文字を取得
    func splitTextsAtCursor() -> (left: String, right: String)? {
        guard let currentRange = self.selectedTextRange else {
            return nil
        }

        let currentPosition = currentRange.start
        guard let leftRange = self.textRange(from: self.beginningOfDocument, to: currentPosition), let leftText = self.text(in: leftRange) else {
            return nil
        }

        guard let rightRange = self.textRange(from: currentPosition, to: self.endOfDocument), let rightText = self.text(in: rightRange) else {
            return nil
        }

        return (left: leftText, right: rightText)
    }
}
