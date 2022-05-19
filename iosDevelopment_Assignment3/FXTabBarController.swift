//
//  FXTabBarController.swift
//
//

import UIKit

class FXTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildsVC()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:(UIColor.init(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1.0))], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:(UIColor.init(red: 75 / 255, green: 128 / 255, blue: 253 / 255, alpha: 1.0))], for: .selected)
        
        self.delegate = self
        
        tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
        let appearance: UITabBarAppearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        } else {
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = .blue
        tabBar.barTintColor = .white
        }
    }
    
    func addChildsVC() {
        let homeVC = HomeViewController()
        let homeNav = FXNavController.init(rootViewController: homeVC)
        homeNav.tabBarItem.title = "Home"
        homeNav.tabBarItem.image = UIImage.init(systemName: "house.circle")
        homeNav.tabBarItem.selectedImage = UIImage.init(systemName: "house.circle.fill")
        
        let bookingOrderVC = BookingOrderViewController()
        let bookingOrderNav = FXNavController.init(rootViewController: bookingOrderVC)
        bookingOrderNav.tabBarItem.title = "Booking"
        bookingOrderNav.tabBarItem.image = UIImage.init(systemName: "book.circle")
        bookingOrderNav.tabBarItem.selectedImage = UIImage.init(systemName: "book.circle.fill")
        
        let mineVC = MineViewController()
        let mineNav = FXNavController.init(rootViewController: mineVC)
        mineNav.tabBarItem.title = "Mine"
        mineNav.tabBarItem.image = UIImage.init(systemName: "person.circle")
        mineNav.tabBarItem.selectedImage = UIImage.init(systemName: "person.circle.fill")
        
        self.addChild(homeNav)
        self.addChild(bookingOrderNav)
        self.addChild(mineNav)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
          
        return true
        
    }
    
    @objc override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
