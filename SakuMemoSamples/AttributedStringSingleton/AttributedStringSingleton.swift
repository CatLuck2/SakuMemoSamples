//
//  AttributedStringSingleton.swift
//  SakuMemoSamples
//
//  Created by Nekokichi on 2022/01/14.
//

import UIKit

final public class AttributedStringSingleton {
    private init() {}
    public static let shared = AttributedStringSingleton()
    private let serialQueue = DispatchQueue(label: "serial")
    private var selectedStringInTextView: String?
    
    public func setSelectedString(text: String) {
        serialQueue.sync {
            selectedStringInTextView = text
        }
    }
    
    public func getSelectedString() -> String? {
        serialQueue.sync {
            selectedStringInTextView
        }
    }

}
