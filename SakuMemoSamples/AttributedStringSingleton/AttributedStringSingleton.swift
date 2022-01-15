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
    private var selectedRangeFirstIndex: String.Index?
    private var selectedRangeLastIndex: String.Index?
    private var selectedFontsize: CGFloat?
    
    public func setString(text: NSMutableAttributedString) {
        serialQueue.sync {
            selectedStringInTextView = text
        }
    }
    
    public func setIndex(firstIndex: String.Index, LastIndex: String.Index) {
        serialQueue.sync {
            selectedRangeFirstIndex = firstIndex
            selectedRangeLastIndex = LastIndex
        }
    }
    
    public func setFontsize(fontsize: CGFloat) {
        serialQueue.sync {
            selectedFontsize = fontsize
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

}
