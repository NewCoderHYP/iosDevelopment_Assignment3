//
//  RegisteredViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 10/05/2022.
//

import UIKit

class RegisteredViewController: BaseViewController {

    
    @IBOutlet weak var xuehaoTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var banjiTF: UITextField!
    
    var sex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
    }
    
    
    @IBAction func registeredButtonAction(_ sender: Any) {

        guard let studentNum = xuehaoTF.text,studentNum.count > 0  else {
            return
        }
        
        guard let name = nameTF.text,name.count > 0  else {
            return
        }
        
        guard let pwd = pwdTF.text,pwd.count > 0  else {
            return
        }
        
        guard let banji = banjiTF.text,banji.count > 0  else {
            return
        }
        
        UIApplication.shared.windows[0].rootViewController = FXTabBarController()

    }
    

}
