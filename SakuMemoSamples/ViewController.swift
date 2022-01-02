//
//  ViewController.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2021/12/27.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController {
    
    private var fpc = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    @IBOutlet weak var selectedString: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func presentHalfModalButton(_ sender: UIButton) {
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "fpc") as? FloatingPanelViewController else { return }
        self.presentFloatingPanel(nextVC: destinationVC)
    }
    
    @IBAction func CloseModalButton(_ sender: UIButton) {
        fpc.removePanelFromParent(animated: true, completion: nil)
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
        fpc.move(to: .half, animated: true, completion: nil)
        fpc.addPanel(toParent: self)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        let location = textView.selectedRange.location
        let length = textView.selectedRange.length
        if length <= 0 {
            selectedString.text?.removeAll()
            return
        } else {
            let strIndex = textView.text.startIndex
            guard let startIndex = textView.text.index(strIndex, offsetBy: location, limitedBy: textView.text.endIndex),
                      let endIndex = textView.text.index(strIndex, offsetBy: location+length-1, limitedBy: textView.text.endIndex) else {
                return
            }
            selectedString.text = String(textView.text[startIndex...endIndex])
        }
    }
}
