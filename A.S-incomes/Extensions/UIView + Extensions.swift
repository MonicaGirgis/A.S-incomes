//
//  UIView + Extensions.swift
//  FFLASHH
//
//  Created by Moca on 5/26/21.
//

import UIKit

enum Transition {
    
    case top
    case bottom
    case right
    case left
    
    var type : String {
        switch self {
        case .top :
            return convertFromCATransitionSubtype(CATransitionSubtype.fromBottom)
        case .bottom :
            return convertFromCATransitionSubtype(CATransitionSubtype.fromTop)
        case .right :
            return convertFromCATransitionSubtype(CATransitionSubtype.fromLeft)
        case .left :
            return convertFromCATransitionSubtype(CATransitionSubtype.fromRight)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
    guard let input = input else { return nil }
    return CATransitionSubtype(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
    return input.rawValue
}

extension UIView {
    
    func makeRoundedCorners(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
    func makeRoundedCornersUsingWidth() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func makeRoundedCornersWith(radius: CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func addBottomView(alpha: CGFloat? = nil, color: UIColor){
        let view = UIView()
        view.alpha = alpha ?? 1.0
        view.backgroundColor = color
        view.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 1)
        layer.masksToBounds = true
        self.addSubview(view)
    }
    
    func makeShadows(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
    
    func dropShadow(radius: CGFloat = 1, scale: Bool = true) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = 1
      }
    
    func makeShadowsWith(color: CGColor, opacity: Float, shadowRadius: CGFloat){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
        self.layer.masksToBounds = false
    }
    
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
    
    func makeBorders(borderColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)){
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
    }
    
    func removeBorders() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setBorderColor(color: UIColor,width: CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func rotate(rotate: Bool){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                if rotate{
                    self.transform = CGAffineTransform(rotationAngle: .pi)
                }
                else{
                    self.transform = CGAffineTransform.identity
                }
            }
        }
    }

    func EmptyView(image: UIImage = UIImage(named: "default")!, title:String = "", message:String = "", actionTitle : String = "", show : Bool = true) {
        //Title Label
        let titleLabel = UILabel()
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        titleLabel.text  = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Cairo-Regular", size: 20)
        titleLabel.numberOfLines = 0
        
        //ImageView
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        imageView.image = image
        
        //Message Label
        let textLabel = UILabel()
        textLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        textLabel.text  = message
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Cairo-Regular", size: 16)
        textLabel.numberOfLines = 0
        
        //Action Button
        let loginButton: UIButton = UIButton()
        loginButton.backgroundColor = .primary
        loginButton.widthAnchor.constraint(lessThanOrEqualToConstant: (self.frame.width)).isActive = true
        loginButton.setTitleColor(UIColor.primary, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Cairo-Regular", size: 17)
        loginButton.titleLabel?.numberOfLines = 0
        loginButton.setTitle(actionTitle, for: .normal)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 16,bottom: 5,right: 16)
        
//        loginButton.onTap {
//            DispatchQueue.main.async {
//                if let ad = UIApplication.shared.delegate as? AppDelegate {
//                    ad.setController()
//                }
//            }
//        }
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        if actionTitle.count > 0 {
            stackView.addArrangedSubview(loginButton)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if show {
        self.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -66),
                stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16),
                stackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 16),
                stackView.widthAnchor.constraint(lessThanOrEqualToConstant: (self.frame.width - 32))
            ])
        } else {
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    func showAnimateView(_ view: UIView, isShow: Bool, direction: Transition, duration : Float = 0.8 ) {
        if isShow {
            view.isHidden = false
            self.bringSubviewToFront(view)
            pushTransition(CFTimeInterval(duration), view: view, withDirection: direction)
        }
        else {
            self.sendSubviewToBack(view)
            view.isHidden = true
            pushTransition(CFTimeInterval(duration), view: view, withDirection: direction)
        }
    }
    
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
           let offset: CGFloat = self.frame.width / desiredCurve!
           let bounds: CGRect = self.bounds
           
           let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
           let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
           let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
           let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
           rectPath.append(ovalPath)
           
           // Create the shape layer and set its path
           let maskLayer: CAShapeLayer = CAShapeLayer()
           maskLayer.frame = bounds
           maskLayer.path = rectPath.cgPath
           
           // Set the newly created shape layer as the mask for the view's layer
           self.layer.mask = maskLayer
       }
    
    func pushTransition(_ duration: CFTimeInterval, view: UIView, withDirection direction: Transition) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = convertToOptionalCATransitionSubtype(direction.type)
        animation.duration = duration
        view.layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.moveIn))
    }
}
