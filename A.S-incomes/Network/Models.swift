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
    let Id : String?
    let amountNet : String?
    let title : String?
    let date : String?
    let add_by : String?
    let remain_amount : String?

    enum CodingKeys: String, CodingKey {

        case Id = "c_id"
        case amountNet = "c_amount_net"
        case title = "c_title"
        case date = "c_date"
        case add_by = "c_add_by"
        case remain_amount = "remain_amount"
    }
}

struct Bond: Decodable {
    let tId : String?
    let treseauryAmount : ValueWrapper?
    let exportTxt : String?
    let exportAmount : ValueWrapper?
    let importTxt : String?
    let importAmount : ValueWrapper?
    
    enum CodingKeys: String, CodingKey {

        case tId = "t_id"
        case treseauryAmount = "treseaury_amount"
        case exportTxt = "export_txt"
        case exportAmount = "export_amount"
        case importTxt = "import_txt"
        case importAmount = "import_amount"
    }
}
