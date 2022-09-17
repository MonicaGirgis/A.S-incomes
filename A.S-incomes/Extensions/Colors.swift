//
//  Colors.swift
//  User
//
//  Created by MacBookPro on 12/22/17.
//  Copyright © 2017 Ragab Mohammed. All rights reserved.
//

import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
            
        case self.secondary.rawValue:
            return .secondary
              
        default:
            return nil
        }
    }
}

extension UIColor {
    
    
    public class var appColor: UIColor {
        return UIColor(hex: 0x106A9C)
    }
    
    static var systemBackground: UIColor {
        let lightColor = UIColor.white
        let darkColor = UIColor.black
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .light ? lightColor : darkColor }
        }
        return lightColor
    }
    
    // Primary Color
    static var primary : UIColor {
        return UIColor(hex: 0x1D242E)
        
    }
    
    static var secondary : UIColor {
        return  UIColor(hex: 0x8D8C96)
        
    }
    
    static var backgroundColor : UIColor {
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
    
    func UInt()->UInt32{
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            var colorAsUInt : UInt32 = 0
            colorAsUInt += UInt32(red * 255.0) << 16 +
                UInt32(green * 255.0) << 8 +
                UInt32(blue * 255.0)
            return colorAsUInt
        }
        return 0xCC6699
    }
}

extension UIColor {
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
