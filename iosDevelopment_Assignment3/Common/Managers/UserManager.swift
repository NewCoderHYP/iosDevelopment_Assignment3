//
//  UserManager.swift
//  iosDevelopment_Assignment3
//
//

import Foundation
import CoreLocation
import UIKit

enum UserGender: Int {
    case `none` = 0
    case man = 1
    case women = 2
    
    var info: (title: String, image: UIImage?) {
        switch self {
        case .none: return ("unknown", nil)
        case .man: return ("man", #imageLiteral(resourceName: "man"))
        case .women: return ("women", #imageLiteral(resourceName: "women"))
        }
    }
    
}
struct LoginPassBody: Codable {
    var phone: String?
    var password: String?
}

struct LoginCodeBody: Codable {
    var phone: String?
    var smsCode: String?
}

struct PhoneCodeBody: Codable {
    var phone: String?
    var type: Int?
}

struct PwdCodeBody: Codable {
    var password: String?
    var smsCode: String?
}

struct PwdTwoBody: Codable {
    var newPassword: String?
    var oldPassword: String?
}

class User : Codable, Cacheable {
    static var cacheName: String = "iosDevelopment_Assignment3LoginLocalInfo"
        var createTime: String?
        var userEmail: String?
        var userFirstname: String?
        var userId: Int = 0
        var userLastname: String?
        var userLatitude: Double?
        var userLongitude: Double?
        var userNum: String?
        var userPassword: String?
        var userRank: String?
        var userSex: Int = 0
        var userToken: String?
    }




struct UserLoginResponse : Codable {
    var data : User?
}

private struct FocusUserBody: Codable {
    var type: Int?
    var id: Int?
}

struct UserManager {
    static var user: User?
    static var token: String?
    static var coordinate: CLLocationCoordinate2D?
    
    static func loadUserFromCache() {
        user = User.loadFromDisk(.document)
        token = user?.userToken
    }
    
    static var isLogin: Bool {
        if user != nil && user?.userToken != nil {
            return true
        }
        return false
    }
    
    static func loginPermission(_ inController: UIViewController?, completion:(()->())?) {
        if isLogin {
            completion?()
            return
        }
        
        guard let inController = inController else { return }
        let nav = FXNavController(rootViewController: LoginViewController())
//        login.loginBlock = {
//            completion?()
//        }
        nav.modalPresentationStyle = .fullScreen
        inController.present(nav, animated: true, completion: nil)
    }
    
    static func loginUpdateUser(_ info: User?) {
        guard let info = info else { return }
        user = info
        user?.userToken = info.userToken
        token = info.userToken
        cacheUser()
    }
    
    private static func cacheUser() {
        User.updateDiskCache(user, .document)
    }
    
    private static func clearUser() {
        user = nil
        token = nil
        cacheUser()
    }
    
    static func logout() {
        clearUser()
        SPFileManager.clear()
        NotificationCenter.default.post(name: Notification(name: .init(rawValue: "kUserLogout")).name, object: nil)
        let storyboard1 = UIStoryboard.init(name: "Main", bundle: nil);
        let vc = storyboard1.instantiateViewController(identifier: "ViewController")

        UIApplication.shared.windows[0].rootViewController = FXNavController.init(rootViewController: vc)
    }
    
    
}
