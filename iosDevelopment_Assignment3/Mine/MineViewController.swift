//
//  MineViewController.swift
//  iosDevelopment_Assignment3
//
//  Created by Congcong Zhao on 18/5/2022.
//

import UIKit

class MineViewController: BaseViewController {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    let userDefaults = UserDefaults()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helloLabel.text = "HI! " + (UserDefaults.standard.string(forKey: "account") ?? "")
        userEmail.text = "Your Account: " + (UserDefaults.standard.string(forKey: "name") ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Mine"
    }

    @IBAction func modifyInformation(_ sender: Any) {
        self.navigationController?.pushViewController(modifyInformationController(), animated: true)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.navigationController?.pushViewController(changePasswordController(), animated: true)
    }
    
    @IBAction func Logout(_ sender: Any) {
    //userDefaults.setValue(nil, forKey: "First_name")
    //userDefaults.setValue(nil, forKey: "Last_name")
    //userDefaults.setValue(nil, forKey: "Email")
    //userDefaults.setValue(nil, forKey: "Password")
        let storyboard1 = UIStoryboard.init(name: "Main", bundle: nil);
        let vc = storyboard1.instantiateViewController(identifier: "ViewController")
        let mainVC = FXNavController(rootViewController: vc)
        UIApplication.shared.windows[0].rootViewController = mainVC
    }
}
