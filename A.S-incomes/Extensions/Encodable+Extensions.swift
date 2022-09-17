//
//  Encodable+Extensions.swift
//  FFLASHH
//
//  Created by Mina Malak on 22/05/2021.
//

import UIKit



extension Dictionary {
    func percentEncoded() -> Data? {
      return map { key, value in
        let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
        let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
        return escapedKey + "=" + escapedValue
      }
      .joined(separator: "&")
      .data(using: .utf8)
    }
  }

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
      let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
      let subDelimitersToEncode = "!$&'()*+,;="

      var allowed = CharacterSet.urlQueryAllowed
      allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
      return allowed
    }()
}


extension Encodable {
    
    // this would try to encode an encodable type and decode it into an a dictionary
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    // this would try to encode an encodable type and decode it into an array of dictionaries
    var dictionaries: [[String: Any]] {
        guard let data = try? JSONEncoder().encode(self) else { return [] }
        return (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]] ?? []
    }
    
    // this would try to encode an encodable type and decode it into a dictionary with dictionaries as its value
    var nestedDictionaries: [String: [String: Any]] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: [String: Any]] ?? [:]
    }
    
    // this will return only the properties that are referring to a nested structure/classe
    var nestedDictionariesOnly: [String: [String: Any]] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return ((try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]).compactMapValues { $0 as? [String:Any] }
    }
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            if let value = (value as? Int), value % 1 == 0 {
                output +=  "\"\(key)\":\(value),"
            } else if let value = (value as? Double) {
                output +=  "\"\(key)\":\(value),"
            } else if let value = (value as? Dictionary) {
                output +=  "\"\(key)\":\"\(String(describing: value.queryString))\","
            } else {
                output +=  "\"\(key)\":\"\(value)\","
            }
            
        }
        output = String(output.dropLast())
        return output
    }
}
