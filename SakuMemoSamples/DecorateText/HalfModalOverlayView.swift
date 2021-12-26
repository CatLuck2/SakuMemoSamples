//
//  HalfModalOverlayView.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2021/12/27.
//

import UIKit

final class SemiModalOverlayView: UIView {

    // MARK: Public Properties
    var isActive: Bool = false {
        didSet {
            alpha = isActive ? 0.5 : 0.0
        }
    }

    // MARK: Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

// MARK: - Private Functions
extension SemiModalOverlayView {

    private func setup() {
        backgroundColor = UIColor.black
        alpha = 0.5
    }
}
