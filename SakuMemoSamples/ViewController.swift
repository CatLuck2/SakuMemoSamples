//
//  ViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2021/12/27.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private var fpc = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        fpc.delegate = self
    }
    
    @IBAction func presentHalfModalButton(_ sender: UIButton) {
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "fpc") as? FloatingPanelViewController else { return }
        self.presentFloatingPanel(nextVC: destinationVC)
    }
    
    /// sheetPresentationControllerでハーフモーダルを表示
    func presentSheetPresentationController(destinationVC: UIViewController) {
        let halfModalViewController = destinationVC
        if let halfModalVC = halfModalViewController.sheetPresentationController {
            halfModalVC.detents = [.medium(), .large()]
            halfModalVC.prefersScrollingExpandsWhenScrolledToEdge = false
            halfModalVC.prefersGrabberVisible = true
            halfModalVC.preferredCornerRadius = 12.0
            halfModalVC.largestUndimmedDetentIdentifier = .medium
        }
    }
    
    /// FloatingPanelでハーフモーダルを表示
    func presentFloatingPanel(nextVC: UIViewController) {
        fpc.set(contentViewController: nextVC)
        fpc.addPanel(toParent: self)
    }
}
