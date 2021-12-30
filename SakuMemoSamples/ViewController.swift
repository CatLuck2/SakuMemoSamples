//
//  ViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2021/12/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let halfModalViewController = segue.destination
        if let halfModalVC = halfModalViewController.sheetPresentationController {
            halfModalVC.detents = [.medium(), .large()]
            halfModalVC.prefersScrollingExpandsWhenScrolledToEdge = false
            halfModalVC.prefersGrabberVisible = true
            halfModalVC.preferredCornerRadius = 12.0
            halfModalVC.largestUndimmedDetentIdentifier = .medium
        }
    }
}
