//
//  UILabel + Extensions.swift
//  customer
//
//  Created by Monica Girgis Kamel on 16/01/2022.
//

import UIKit

extension UILabel {
    
    func strikeThrough() {
        if let lblText = self.text {
            let attributeString =  NSMutableAttributedString(string: lblText)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        }
    }
}

//extension JVFloatLabeledTextField{
//    var CustomTextField: JVFloatLabeledTextField{
//        self.makeRoundedCornersWith(radius: 8.0)
//        self.makeBorders(borderColor: .systemGray2)
//        return self
//    }
//    
//    open override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 4 , dy: 0)
//        }
//
//        
//    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 4 , dy: 0)
//    }
//}
