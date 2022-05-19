//
//  RegisteredViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Mingduo Wang on 10/05/2022.
//

import UIKit

class RegisteredViewController: BaseViewController {

    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var txtAccount: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
    }
    
    
    @IBAction func registeredButtonAction(_ sender: Any) {

        guard let account = txtAccount.text,account.count > 0  else {
            showAlert(message: "Please, input your account")
            return
        }
        
        guard let name = txtName.text,name.count > 0  else {
            showAlert(message: "Please, input your name")
            return
        }
        
        guard let password = txtPassword.text,password.count > 0  else {
            showAlert(message: "Please, input your password")

            return
        }
        
        guard let confirmPassword = txtConfirmPassword.text,confirmPassword == password  else {
            showAlert(message: "The passwords are inconsisten")
            return
        }
        
        UserDefaults.standard.set(account, forKey: "account")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.synchronize()
        
        showAlert(message: "Successful registration to log in")

    }
    
    func showAlert(title: String = "Alert", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
    

}
