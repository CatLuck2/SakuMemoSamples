//
//  AttributedStringViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2022/01/02.
//

import UIKit
import FloatingPanel

protocol MyTextViewDelegate {
    func setStringToTextView(string: NSMutableAttributedString)
}

class AttributedStringViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    private var bool: Bool = false
    private var fpc = FloatingPanelController()
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
//        let stm = SymbolicTraitsModifer(font: textView.font!).bold()
//        let string = NSMutableAttributedString(string: textView.text)
//        string.addAttribute(.font, value: stm.build(), range: .init(location: 0, length: textView.text.count))
//        textView.attributedText = string
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "fpc") as? FloatingPanelViewController else { return }
        self.presentFloatingPanel(nextVC: destinationVC)
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
    
    /// sheetPresentationControllerでハーフモーダルを表示
    func presentSheetPresentationController(destinationVC: UIViewController) {
        let halfModalViewController = destinationVC
        if let halfModalVC = halfModalViewController.sheetPresentationController {
            halfModalVC.detents = [.medium(), .large()]
            halfModalVC.prefersScrollingExpandsWhenScrolledToEdge = false
            halfModalVC.prefersGrabberVisible = true
            halfModalVC.preferredCornerRadius = 12.0
            halfModalVC.largestUndimmedDetentIdentifier = .medium
        }
    }
    
    /// FloatingPanelでハーフモーダルを表示
    func presentFloatingPanel(nextVC: UIViewController) {
        fpc.set(contentViewController: nextVC)
        fpc.move(to: .half, animated: true, completion: nil)
        fpc.addPanel(toParent: self)
    }
}

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
            let fontsizeOfAttributeString = AttributedStringSingleton.shared.get().attribute(.font, at: 0, effectiveRange: nil) as! UIFont
            AttributedStringSingleton.shared.setFontsize(fontsize: fontsizeOfAttributeString.pointSize)
            AttributedStringSingleton.shared.selectedRange = textView.selectedRange
        }
    }
}

extension AttributedStringViewController: MyTextViewDelegate {
    func setStringToTextView(string: NSMutableAttributedString) {
        textView.attributedText = string
    }
}
