//
//  LoginViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 10/05/2022.
//

import UIKit



class LoginViewController: BaseViewController {
    @IBOutlet var accountFld: UITextField!
    @IBOutlet var passwordFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
        let accountStr = UserDefaults.standard.string(forKey: "account")
        self.accountFld.text = accountStr

    }

    @IBAction func loginAction(_ sender: Any) {
        guard let account = accountFld.text,account.count > 0  else {
            return
        }
        
        guard let password = passwordFld.text,password.count > 0  else {
            return
        }
        
        UIApplication.shared.windows[0].rootViewController = FXTabBarController()

    }
    
    
    @IBAction func registeredAction(_ sender: Any) {
        self.navigationController?.pushViewController(RegisteredViewController(), animated: true)
    }
    
}
