//
//  Models.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 23/05/2022.
//

import Foundation
import UIKit

struct Response<T: Decodable>: Decodable {
    var data: [T]
}

struct FlagMessageResponse : Decodable {
    var message : String?
}

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
struct Amounts: Codable {
    let id : String?
    let amountNet : String?
    let title : String?
    let date : String?
    let add_by : String?
    let remain_amount : String?

    enum CodingKeys: String, CodingKey {

        case id = "c_id"
        case amountNet = "c_amount_net"
        case title = "c_title"
        case date = "c_date"
        case add_by = "c_add_by"
        case remain_amount = "remain_amount"
    }
}

struct Expense: Codable {
    let id: String?
    let expensesAmount: ValueWrapper?
    let description: String?
    let date: String?
    let updatedDate: String?
    
    enum CodingKeys: String, CodingKey {

        case id = "cd_id"
        case expensesAmount = "cd_amount_expenses"
        case description = "cd_description"
        case date = "cd_add_date"
        case updatedDate = "cd_update_date"
    }
}

struct Bond: Decodable {
    let tId : String?
    let treseauryAmount : ValueWrapper?
    let exportAmount : ValueWrapper?
    let text : String?
    let importAmount : ValueWrapper?
    let date: String?
    
    enum CodingKeys: String, CodingKey {

        case tId = "t_id"
        case treseauryAmount = "treseaury_amount"
        case exportAmount = "export_amount"
        case text = "text"
        case importAmount = "import_amount"
        case date = "date"
    }
}

struct DestinationInfo: Codable {
    let name: String?
    let amount: String?
}

struct User: Codable {
    let id: Int?
    let type: String?
}

struct Destination: Codable {
    let name: String?
}
