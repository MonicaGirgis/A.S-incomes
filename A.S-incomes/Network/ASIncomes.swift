//
//  Baquala.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 24/03/2022.
//

import Foundation

enum ASIncomes{
    case getAllAmounts
    case getExpenseDetails(id: Int)
    case insertNewAmount
    case insertExpensesDetails
}

extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "SubFolderURL") as? String ?? ""
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
        switch self {
        case .getAllAmounts:
            return "get_all_amount"
        case .getExpenseDetails:
            return "get_expense_details"
        case .insertNewAmount:
            return "insert_new_amount"
        case .insertExpensesDetails:
            return "insert_expenses_details"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .insertNewAmount, .insertExpensesDetails:
            return .post
        default:
            return .get
        }
    }
    
    
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        switch self {
        case .getExpenseDetails(let id):
            return [URLQueryItem(name: "id", value: "\(id)")]
        default:
            return queryItems
        }
    }
    
    var body: [String: Any]?{
        var params: [String: Any] = [:]
        
       return nil
    }
    
    var headers : [httpHeader] {
        var headers: [httpHeader] = []
//        headers.append(httpHeader(key: "lang", value: (Language.getCurrentLanguage() == "ar") ? "ar" : "en"))
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
