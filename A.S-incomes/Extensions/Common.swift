
//
//  Common.swift
//  TATX
//
//  Created by Mohammed Ragab on 12/11/18.
//  Copyright © 2018 TATX. All rights reserved.
//

import UIKit
import MessageUI

import Foundation
import ContactsUI
enum ContactsFilter {
    case none
    case mail
    case message
}
extension String {
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}
extension Dictionary {
    func contains(key: Key) -> Bool {
        let value = self.contains { (k,_) -> Bool in key == k }
        return value
    }
}
class PhoneContacts {
    
    class func getContacts(filter: ContactsFilter = .none) -> [CNContact] {
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        return results
    }
}



class Bind<T> {
    typealias Listener = (T?) -> Void
    var listener : Listener?
    var value : T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value : T?) {
        self.value = value
    }
    func bind(listener : Listener?) {
        self.listener = listener
        listener?(value)
    }
}

class Common {
    class func isValid(email : String)->Bool{
        let emailTest = NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
    class func isValid(mobile : String)->Bool{
        //return NSPredicate(format:"SELF MATCHES %@", "^5\\d{8}$").evaluate(with: mobile)
        return true
    }
    class func getBackButton()->UIBarButtonItem{
        let backItem = UIBarButtonItem()
        backItem.title = ""
        return backItem// This will show in the next view controller being pushed
    }
    
    class func getCurrentCode()->String?{
        return (Locale.current as NSLocale).object(forKey:  NSLocale.Key.countryCode) as? String
    }
    class func open(url urlString: String) {
        if let  url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    // MARK:- Send Message
    
    class func sendMessage(to numbers : [String], text : String, from view : UIViewController & MFMessageComposeViewControllerDelegate) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = numbers
            controller.messageComposeDelegate = view
            view.present(controller, animated: true, completion: nil)
        }
    }
    
    class func getChatId(with requestId : Int?) -> String {
        
        guard  let requestId = requestId else {
            return ProcessInfo().globallyUniqueString }
        
        return "\(requestId)" //userId <= providerId ? "u\(userId)_p\(providerId)" : "p\(providerId)_u\(userId)"
        
    }
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
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
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

struct AppFontName {
    static let regular = "Cairo-Regular"//CourierNewPSMT"
    static let bold = "Cairo-Bold"//"CourierNewPS-BoldMT"
    static let italic = "Cairo-Light"//"CourierNewPS-ItalicMT"
}

extension UIFont {
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc convenience init?(myCoder aDecoder: NSCoder) {
        let nsctFontUIUsage =
            UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
        
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[nsctFontUIUsage] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.regular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.bold
                case "CTFontObliqueUsage":
                    fontName = AppFontName.italic
                default:
                    fontName = AppFontName.regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
@IBDesignable
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
//class PaddingLabel: UILabel {
//
//    var insets = UIEdgeInsets.zero
//
//    func padding(_ top: CGFloat = 0, _ bottom: CGFloat = 0, _ left: CGFloat = 16, _ right: CGFloat = 16) {
//        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
//        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
//    }
//
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: rect.inset(by: insets))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        get {
//            var contentSize = super.intrinsicContentSize
//            contentSize.height += insets.top + insets.bottom
//            contentSize.width += insets.left + insets.right
//            return contentSize
//        }
//    }
//}

import Foundation
import AVFoundation

class AVPlayerHelper {
    
    private var player : AVAudioPlayer?
    
    //MARK:- Play audio
    
    func play(file name : String? = "outgoing.aiff", isLooped : Bool = true){
        
        if let path = Bundle.main.path(forResource: name, ofType: nil){
            
            let url = URL(fileURLWithPath: path)
            
            do {
                
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.numberOfLoops = isLooped ? Int.max : 0
                self.player?.play()
                
            } catch let err {
                
                print("Error in playing audio ",err.localizedDescription)
            }
            
        }
    }
    
    //MARK:- Stop Audio
    
    func stop(){
        
        self.player?.stop()
        
    }
    
}
