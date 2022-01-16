//
//  AttributedStringSingleton.swift
//  SakuMemoSamples
//
//  Created by Nekokichi on 2022/01/14.
//

import UIKit

final public class AttributedStringSingleton {
    private init() {}
    var delegate: MyTextViewDelegate?
    public static let shared = AttributedStringSingleton()
    private let serialQueue = DispatchQueue(label: "serial")
    private var selectedStringInTextView: NSMutableAttributedString?
    private var selectedFontsize: CGFloat?
    var selectedRange: NSRange?
    
    public func setString(text: NSMutableAttributedString) {
        serialQueue.sync {
            selectedStringInTextView = text
        }
    }
    public func setFontsize(fontsize: CGFloat) {
        serialQueue.sync {
            selectedFontsize = fontsize
        }
    }
    
    public func getRange(range: NSRange) {
        serialQueue.sync {
            selectedRange = range
        }
    }
    
    func setDelegate(delegate: MyTextViewDelegate?) {
        self.delegate = delegate
    }
    
    public func get() -> NSMutableAttributedString {
        serialQueue.sync {
            selectedStringInTextView!
        }
    }
    
    public func getFontsize() -> CGFloat {
        serialQueue.sync {
            selectedFontsize!
        }
    }
    
    public func getRange() -> NSRange {
        serialQueue.sync {
            selectedRange!
        }
    }

}
