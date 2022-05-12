//
//  UIViewExtensions.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 09/05/2022.
//

import UIKit

@objc extension UIView {
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width;
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width;
            self.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height;
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height;
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x;
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y;
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width;
        }
        set {
            var frame = self.frame
            frame.size.width = newValue;
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height;
        }
        set {
            var frame = self.frame
            frame.size.height = newValue;
            self.frame = frame
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue;
            self.frame = frame
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue;
            self.frame = frame
        }
    }
    
    func setMaxRight(maxRight: CGFloat) {
        let maxWidth = maxRight - left
        if maxWidth >= 0 && self.width > maxWidth {
            self.width = maxWidth;
        }
    }
    
    func removeAllSubviews(){
        while self.subviews.count > 0 {
            let subView = self.subviews.first
            subView?.removeFromSuperview()
        }
    }
    
    func toImage() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    @discardableResult
    func corner(withRadius radius: CGFloat = 6, color: UIColor = .white, borderWidth: CGFloat = 0, borderColor: UIColor = .black) -> CALayer? {
        var cornerLayer = objc_getAssociatedObject(self, UnsafeRawPointer.init(bitPattern: "ViewCornerLayerKey".hashValue)!) as? CALayer
        if cornerLayer == nil {
            cornerLayer = CALayer()
            layer.addSublayer(cornerLayer!)
            layer.insertSublayer(cornerLayer!, at: 0)
            objc_setAssociatedObject(self, UnsafeRawPointer.init(bitPattern: "ViewCornerLayerKey".hashValue)!, cornerLayer!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        cornerLayer?.masksToBounds = true
        cornerLayer?.cornerRadius = radius
        cornerLayer?.backgroundColor = color.cgColor
        cornerLayer?.borderWidth = borderWidth
        cornerLayer?.borderColor = borderColor.cgColor
        
        if bounds.size.width == 0  || bounds.size.height == 0 {
            layoutIfNeeded()
        }
        cornerLayer?.frame = bounds
        backgroundColor = .clear
        return cornerLayer
    }
    
    func shadow(withColor color: UIColor = UIColor.hex("#000000").withAlphaComponent(0.2),
                opacity: Float = 0.6,
                radius: CGFloat = 4,
                offset: CGSize = CGSize()) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    @discardableResult
    func addCornerAndShadow(withCornerRadius cornerRadius: CGFloat = 6,
                            cornerColor: UIColor = .white,
                            borderWidth: CGFloat = 0,
                            borderColor: UIColor = .black,
                            shadowColor: UIColor = UIColor.hex("#000000").withAlphaComponent(0.2),
                            shadowOpacity: Float = 0.6,
                            shadowRadius: CGFloat = 4,
                            shadowOffset: CGSize = CGSize()) -> CALayer? {
        shadow(withColor: shadowColor, opacity: shadowOpacity, radius: shadowRadius, offset: shadowOffset)
        return corner(withRadius: cornerRadius, color: cornerColor, borderWidth: borderWidth, borderColor: borderColor)
    }
    
}
