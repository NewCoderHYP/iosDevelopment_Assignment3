//
//  modifyInformationController.swift
//  iosDevelopment_Assignment3
//
//  Created by Congcong Zhao on 18/5/2022.
//
import Foundation
import UIKit

class modifyInformationController: BaseViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var account: UITextField!

    let userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Booking"
    }
    
    @IBAction func changeButtonAction(_ sender: Any) {
        guard let t_account = account.text,t_account.count > 0  else {
            showAlert(message: "Please, input your account")
            return
        }
        
        guard let t_name = name.text,t_name.count > 0  else {
            showAlert(message: "Please, input your name")
            return
        }
        
        userDefaults.set(t_account, forKey: "account")
        userDefaults.set(t_name, forKey: "name")
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
