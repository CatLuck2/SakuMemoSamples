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
        AttributedStringSingleton.shared.get().addAttribute(.font, value: UIFont.preferredFont(forTextStyle: AttributedStringSingleton.shared.get().attribute(.font, at: 0, effectiveRange: nil) as! UIFont.TextStyle), range: NSMakeRange(0, AttributedStringSingleton.shared.get().length))
        AttributedStringSingleton.shared.setString(text: AttributedStringSingleton.shared.get())
        AttributedStringSingleton.shared.delegate?.setStringToTextView(string: AttributedStringSingleton.shared.get())
    }
    
    @IBAction func plainText(_ sender: UIButton) {
        
    }
    
    @IBAction func bold(_ sender: UIButton) {
//        selectedString.attribute(.font, at: 0, effectiveRange: nil)
    }
    
    @IBAction func underline(_ sender: UIButton) {
        
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
