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

extension AttributedStringViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
}
