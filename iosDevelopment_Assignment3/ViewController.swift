//
//  ViewController.swift
//  iosDevelopment_Assignment3
//
//  

import UIKit

class ViewController: UIViewController {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func signupAction(_ sender: Any) {
        self.navigationController?.pushViewController(RegisteredViewController(), animated: true)
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)

    }
    
}

