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
    
    var strings = [String]()
    
    override func viewDidLoad() {
        
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
        guard let text = textView.text else {
            return
        }
        
        let bullet = "● "
        strings.append("First line of your list")
        strings = strings.map {
            return bullet + $0
        }
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
                attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        let bulletlistString = strings.joined(separator: "\n\n")
        textView.attributedText = NSAttributedString(string: bulletlistString, attributes: attributes)
        label.attributedText = NSAttributedString(string: bulletlistString, attributes: attributes)
    }
    
    @IBAction func numberedListButton(_ sender: UIButton) {
    }
    
    @IBAction func checkListButton(_ sender: UIButton) {
    }
    
    
}

