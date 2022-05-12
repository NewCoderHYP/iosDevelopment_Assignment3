//
//  FXNavController.swift
//  iosDevelopment_Assignment3
//
//

import UIKit

class FXNavController: UINavigationController,UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self 
        navigationBar.tintColor = UIColor.white
        navigationBar.isTranslucent = false
        if #available(iOS 15.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.5) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.5) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        } else {
        navigationBar.barTintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.5) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        self.interactivePopGestureRecognizer?.isEnabled = false
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
            self.navigationBar.isHidden = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count == 1 {
            self.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            
            if navigationController.viewControllers.last != nil {
                
            }
            
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    
    }
    
    
    
    
    

}
