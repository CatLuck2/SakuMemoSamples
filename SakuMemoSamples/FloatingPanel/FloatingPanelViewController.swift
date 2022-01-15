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
        AttributedStringSingleton.shared.setString(text: AttributedStringSingleton.shared.get())
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
    @IBAction func plainText(_ sender: UIButton) {

    }

    @IBAction func bold(_ sender: UIButton) {
        AttributedStringSingleton.shared.get().addAttribute(.font, value:UIFont.boldSystemFont(ofSize: AttributedStringSingleton.shared.getFontsize()), range: AttributedStringSingleton.shared.selectedRange!)
        AttributedStringSingleton.shared.setString(text: AttributedStringSingleton.shared.get())
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
    @IBAction func underline(_ sender: UIButton) {
        
    }
    
}
