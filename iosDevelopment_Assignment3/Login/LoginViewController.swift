//
//  LoginViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Tung Le on 10/05/2022.
//

import UIKit



class LoginViewController: BaseViewController {
    @IBOutlet var accountFld: UITextField!
    @IBOutlet var passwordFld: UITextField!
    
    var accountRegistered: String = ""
    var passwordRegistered: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountRegistered = UserDefaults.standard.string(forKey: "account") ?? ""
        passwordRegistered = UserDefaults.standard.string(forKey: "password") ?? ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
    }

    @IBAction func loginAction(_ sender: Any) {
        guard let accountInput = accountFld.text, accountInput.count > 0  else {
            showAlert(message: "Please, input your account")
            return
        }

        guard let passwordInput = passwordFld.text, passwordInput.count > 0  else {
            showAlert(message: "Please, input your password")
            return
        }
        
        if accountInput == accountRegistered && passwordInput == passwordRegistered {
            UIApplication.shared.windows[0].rootViewController = FXTabBarController()
        } else {
            showAlert(message: "Your account or password incorrect!")
        }
    }
    
    
    @IBAction func registeredAction(_ sender: Any) {
        self.navigationController?.pushViewController(RegisteredViewController(), animated: true)
    }
    
    func showAlert(title: String = "Alert", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}
