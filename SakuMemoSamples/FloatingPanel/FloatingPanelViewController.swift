//
//  FloatingPanelViewController.swift
//  SakuMemoSamples
//
//  Created by Nekokichi on 2022/01/08.
//

import UIKit
import SwiftUI

class FloatingPanelViewController: UIViewController {
    
    @IBAction func headline(_ sender: UIButton) {
        AttributedStringSingleton.shared.get().addAttribute(.font, value:UIFont.preferredFont(forTextStyle: .title1), range: AttributedStringSingleton.shared.selectedRange!)
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
    @IBAction func plainText(_ sender: UIButton) {

    }

    @IBAction func bold(_ sender: UIButton) {
        AttributedStringSingleton.shared.get().enumerateAttribute(.font, in: AttributedStringSingleton.shared.selectedRange!) { result, resultRange, _ in
            if let result = result as? UIFont {
                if result.fontDescriptor.object(forKey: .face)! as! String == "W3" {
                    AttributedStringSingleton.shared.get().addAttribute(.font, value:UIFont.boldSystemFont(ofSize: AttributedStringSingleton.shared.getFontsize()), range: AttributedStringSingleton.shared.selectedRange!)
                }
                if result.fontDescriptor.object(forKey: .face)! as! String == "W6" {
                    AttributedStringSingleton.shared.get().addAttribute(.font, value:UIFont.systemFont(ofSize: AttributedStringSingleton.shared.getFontsize()), range: AttributedStringSingleton.shared.selectedRange!)
                }
            }
        }
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
    @IBAction func underline(_ sender: UIButton) {
        AttributedStringSingleton.shared.get().enumerateAttribute(.underlineStyle, in: AttributedStringSingleton.shared.selectedRange!) { result, resultRange, _ in
            if let _ = result as? Int {
                AttributedStringSingleton.shared.get().removeAttribute(.underlineStyle, range: AttributedStringSingleton.shared.selectedRange!)
            } else {
                AttributedStringSingleton.shared.get().addAttribute(.underlineStyle, value:1, range: AttributedStringSingleton.shared.selectedRange!)
            }
        }
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
}
