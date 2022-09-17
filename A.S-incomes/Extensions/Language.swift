//
//  String.swift
//  Tatx
//
//  Created by Mohammed Ragab on 05/05/2020.
//  Copyright © 2020 International Applications. All rights reserved.
//

import Foundation


class Language  {
    private let APPLE_LANGUAGE_KEY = "AppleLanguages"
    private let FirstTimeLanguage = "plhfirsttimelanguage"
    
    private static var preferredLanguage: [String] {
        let userDefaults = UserDefaults.standard
        let langArray = userDefaults.object(forKey: "AppleLanguages")
        return langArray as? [String] ?? []
    }
   class func getCurrentLanguage() -> String {
   // return (Locale.current.languageCode == "ar" ) ? "ar" : "en"
       let current = preferredLanguage.first!
       if let hyphenIndex = current.firstIndex(of: "-") {
           return String(current[..<hyphenIndex])
       } else {
           return current == "ar" ? "ar" : "en"
       }
    }
}
var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
  override func localizedString(forKey key: String,
                              value: String?,
                              table tableName: String?) -> String {

    guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
        let bundle = Bundle(path: path) else {
        return super.localizedString(forKey: key, value: value, table: tableName)
    }

    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

extension Bundle {

  class func setLanguage(_ language: String) {
    defer {
        object_setClass(Bundle.main, AnyLanguageBundle.self)
    }
    objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    static var Empty : String {
        return ""
    }
    
    static func removeNil(_ value : String?) -> String{
        return value ?? String.Empty
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
