//
//  UIImage + Extensions.swift
//  customer
//
//  Created by Monica Girgis Kamel on 15/01/2022.
//

import UIKit
import Kingfisher

extension UIImage {
    
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

extension UIImageView {
    func getAsync(_ url: String){
        if let imageURL = URL(string: url) {
//            self.contentMode = .scaleAspectFill
            self.kf.indicatorType = .activity //.image(imageData: gifData)//.activity //.custom(indicator: MyIndicator())
          self.kf.setImage(with: imageURL, placeholder: UIImage())
            //self.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }else{
            self.image = UIImage(named: "default")
        }
      }
}
