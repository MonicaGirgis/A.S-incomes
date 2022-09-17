//
//  Baquala.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 24/03/2022.
//

import Foundation

enum ASIncomes{
    // MARK: - login
    
}

extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "URLSubFolder-POS") as? String ?? ""
    }
}

extension ASIncomes: Endpoint{
    var base: String {
        return Bundle.main.baseURL
    }
    
    var urlSubFolder: String {
        return Bundle.main.urlSubFolder
    }
    
    var path: String {
        
    }
    
    var method: HTTPMethod {
        
    }
    
    
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        return queryItems
    }
    
    var body: [String: Any]?{
        var params: [String: Any] = [:]
        
       return nil
    }
    
    var headers : [httpHeader] {
        var headers: [httpHeader] = []
        headers.append(httpHeader(key: "lang", value: (Language.getCurrentLanguage() == "ar") ? "ar" : "en"))
        headers.append(httpHeader(key: "Accept", value: "application/json"))
        return headers
    }
}

extension URLRequest{
    mutating func addHeaders(_ Headers:[httpHeader]){
        for Header in Headers {
            self.addValue(Header.value, forHTTPHeaderField: Header.key)
        }
    }
}
