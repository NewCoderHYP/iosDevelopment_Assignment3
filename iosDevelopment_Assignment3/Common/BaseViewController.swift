//
//  BaseViewController.swift
//  iosDevelopment_Assignment3
//
//
import UIKit

class BaseViewController: UIViewController {
    var rightButtonBlock: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
        if (self.navigationController?.viewControllers.count)! > 1 {
            let backBtn = UIButton.init(type: .custom)
            backBtn.setImage(UIImage.init(named: "back"), for: .normal)
            backBtn.frame = .init(x: 0, y: 0, width: 44, height: 44)
            backBtn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 44-20)
            backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            let barButtonItem = UIBarButtonItem.init(customView: backBtn)
            navigationItem.leftBarButtonItem = barButtonItem
        }
        
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func jumpBtnAction() {
        rightButtonBlock?()
    }

}
