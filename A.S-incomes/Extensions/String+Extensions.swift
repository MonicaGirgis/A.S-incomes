//
//  String+Extensions.swift
//  FFLASHH
//
//  Created by Mina Malak on 22/05/2021.
//

import Foundation
import PhoneNumberKit

extension Double{
    var price: String{
        return String(format: "\("SAR".localized) %.2f", self)
    }
}

extension Int{
    var price: String{
        return String(format: "\("SAR".localized) %.2f", self)
    }
}

extension String {
    
    func getDate(fromFormat: String? = nil, toFormat: String? = nil) -> String {
            var res = ""
            if self.count == "2022-01-06T02:10:25.000000Z".count {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "en_DZ") as Locale
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000000Z" //21
                if let fromFormat = fromFormat {
                    dateFormatter.dateFormat = fromFormat
                }
                let theDate = dateFormatter.date(from: self)
                
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"//"EEE, MMM d, yyyy"
                if let toFormat = toFormat {
                    dateFormatter.dateFormat = toFormat
                }
                res =  dateFormatter.string(from: theDate!)
                
            }else if self != "" {
                res = self
            }
            
            return res
        }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPhoneNumber() -> Bool {
        do {
            _ = try PhoneNumberKit().parse(self, withRegion: "SA", ignoreType: false)
            return true
        }
        catch {
            return false
        }
    }
    
    func dateFormat()-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let newFormat = DateFormatter()
        newFormat.dateFormat = "hh:mm a"
        newFormat.amSymbol = "AM".localized
        newFormat.pmSymbol = "PM".localized
        if let date = formatter.date(from: self){
            return newFormat.string(from: date)
        }
        return ""
    }
    
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
