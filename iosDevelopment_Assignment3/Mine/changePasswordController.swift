//
//  changePasswordController.swift
//  iosDevelopment_Assignment3
//
//  Created by Congcong Zhao on 18/5/2022.
//


import UIKit

class changePasswordController: BaseViewController {

    @IBOutlet weak var password: UITextField!
    let userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Booking"

    }
    
    
    @IBAction func changeButtonAction(_ sender: Any) {
        guard let pwd = password.text, pwd.count > 0  else {
            showAlert(message: "Please, input new password")
            return
        }
        
        
        userDefaults.set(String(password.text!), forKey: "password")
        userDefaults.synchronize()
        
        showAlert(message: "Modify the success")

    }
    
    func showAlert(title: String = "Alert", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}
