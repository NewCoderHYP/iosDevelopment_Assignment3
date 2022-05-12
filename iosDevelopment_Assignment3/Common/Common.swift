//
//  Common.swift
//  iosDevelopment_Assignment3
//
//

import Foundation
import UIKit

struct Const {
    static var screenWidth: CGFloat { return UIScreen.main.bounds.size.width }
    static var screenHeight: CGFloat { return UIScreen.main.bounds.size.height }
    static var screenSafeInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            guard case let window?? = UIApplication.shared.delegate?.window else { return UIEdgeInsets.zero }
            return window.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }
    static var screenSafeBottom: CGFloat { return screenSafeInset.bottom }
    static var statusbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    static var navigationBarHeight: CGFloat { return (statusbarHeight + 44) }
    static var lineHeight: CGFloat { return (1.0 / UIScreen.main.scale) }
}

func printlog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    #if DEBUG
        print("🐣\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

class Common: NSObject {
    /// String  -> Date
    class func string2Date(_ string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }

    // Date -> String
    class func date2String(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}

/// if Collection is nil or emtpy
public func IsCollectionEmpty<T>(_ collection: T?) -> Bool where T: Collection {
    guard let collection = collection else { return true }
    return collection.isEmpty
}

extension Encodable {
    
    public func toJSONString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    public func toJSONData() -> Data? {
        guard let jsonStr = self.toJSONString() else { return nil }
        return jsonStr.data(using: .utf8, allowLossyConversion: false)
    }
}
