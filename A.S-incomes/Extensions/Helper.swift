//
//  Helper.swift
//  customer
//
//  Created by Monica Girgis Kamel on 15/01/2022.
//

import UIKit

internal func createActivityIndicator(_ uiView : UIView)->UIView{
    let container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiView.frame.size
    container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = container.center
    loadingView.backgroundColor = .primary//UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.gray.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.style = UIActivityIndicatorView.Style.large
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    uiView.addSubview(container)
    actInd.startAnimating()
    
    return container
    
}

extension UICollectionView {
    func reloadWithoutAnimation(){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
}

class ArabicCollectionFlow: UICollectionViewFlowLayout {
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return (Language.getCurrentLanguage() == "ar") ? true : false
    }
}

class utilities {
    class func showAlertAr_En(titleEn: String, titleAr: String, msgAr: String, msgEn: String, okLabelAr: String = "موافق", okLabelEn: String = "OK", onVC: UIViewController, cancelOption: Bool = false, cancelLabelAr:String = "إلغاء", cancelLabelEn:String = "Cancel",onCompletion: @escaping ()->() = {},oncancelCompletion: @escaping ()->() = {})
    {
        let language = Language.getCurrentLanguage()
        if language == "en"  {
            // en
            let alertEn = UIAlertController(title: titleEn, message: msgEn, preferredStyle: .alert)
            let OKactionEn = UIAlertAction(title: okLabelEn, style: .destructive)
            {
                (action) in
                onCompletion()
            }
            alertEn.addAction(OKactionEn)
            
            if cancelOption
            {
                let CancelActionEn = UIAlertAction(title: cancelLabelEn, style: .default)
                {
                    (action) in
                    oncancelCompletion()
                }
                alertEn.addAction(CancelActionEn)
            }
            onVC.present(alertEn, animated: true, completion: nil)
            
        }else{
            // ar
            let alertAr = UIAlertController(title: titleAr, message: msgAr, preferredStyle: .alert)
            let OKactionAr = UIAlertAction(title: okLabelAr, style: .destructive)
            {
                (action) in
                onCompletion()
            }
            alertAr.addAction(OKactionAr)
            
            if cancelOption
            {
                let CancelActionAr = UIAlertAction(title: cancelLabelAr, style: .default)
                {
                    (action) in
                    oncancelCompletion()
                }
                alertAr.addAction(CancelActionAr)
            }
            onVC.present(alertAr, animated: true, completion: nil)
        }
    }
    
    class func getAsyncImages(url: String, imageView: UIImageView){
//          let imageURL = URL(string: url)
//          imageView.kf.indicatorType = .activity
//          imageView.kf.setImage(with: imageURL)
      }
      
      static var toURL = { (url:String) -> URL in
          return URL(string: url)!
      }
}
