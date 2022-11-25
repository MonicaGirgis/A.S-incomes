//
//  Baquala.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 24/03/2022.
//

import Foundation

enum ASIncomes{
    case login(name: String, password: String)
    case getAllAmounts
    case getExpenses
    case insertNewAmount(amount: Double, title: String, date: String, userId: Int? = nil)
    case insertExpensesDetails(amount: Double, title: String, date: String, userId: Int? = nil)
    case exportExcel(from: String, to: String)
    case exportExcel2(from: String, to: String)
    case getAllClients
    case updateIncome(id: Int, amount: Double, title: String, date: String, userId: Int? = nil)
    case updateExpense(id: Int, amount: Double, title: String, date: String, userId: Int? = nil)
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
        case .getExpenses:
            return "get_expense_details"
        case .insertNewAmount:
            return "insert_new_amount"
        case .insertExpensesDetails:
            return "insert_expenses_details"
        case .exportExcel:
            return "export_excel"
        case .exportExcel2:
            return "export_excel_sheet2"
        case .getAllClients:
            return "getallclients"
        case .login:
            return "login"
        case .updateIncome:
            return "update_income"
        case .updateExpense:
            return "edit_expenses"
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .insertNewAmount, .insertExpensesDetails, .login, .updateIncome, .updateExpense:
            return .post
        default:
            return .get
        }
    }
    
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .exportExcel(let from, let to), .exportExcel2(let from, let to):
            return [URLQueryItem(name: "date_from", value: from), URLQueryItem(name: "date_to", value: to)]
            
        default:
            return []
        }
    }
    
    var body: [String: Any]?{
        var params: [String: Any] = [:]
        switch self {
        case .login(let name, let password):
            return ["username": name, "password": password]
            
        case .insertNewAmount(let amount, let title, let date, let userId):
            params["amount_v"] = amount
            params["title_v"] = title
            params["add_date"] = date
            
            if let userId = userId {
                params["add_by"] = userId
            }else {
                params["add_by"] = 1
            }
            
            return params
            
        case .insertExpensesDetails(let amount, let title, let date, let userId):
            params["id_amount_net_v"] = 0
            params["amount_expenses_v"] = amount
            params["expenses_details"] = title
            params["add_date"] = date
            
            if let userId = userId {
                params["add_by"] = userId
            }else {
                params["add_by"] = 1
            }
            
            return params
            
        case .updateExpense(let id, let amount, let title, let date, let userId):
            params["amount_expenses_v"] = amount
            params["expenses_details"] = title
            params["changed_id"] = id
            params["add_date"] = date
            
            if let userId = userId {
                params["add_by"] = userId
            }else {
                params["add_by"] = 1
            }
            
            return params
            
        case .updateIncome(let id, let amount, let title, let date, let userId):
            params["amount_v"] = amount
            params["title_v"] = title
            params["changed_id"] = id
            params["add_date"] = date
            
            if let userId = userId {
                params["add_by"] = userId
            }else {
                params["add_by"] = 1
            }
            
            return params
            
        default:
            return nil
        }
    }
    
    var headers : [httpHeader] {
        var headers: [httpHeader] = []
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
