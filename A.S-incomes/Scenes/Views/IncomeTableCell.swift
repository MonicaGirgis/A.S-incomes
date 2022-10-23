//
//  IncomeTableCell.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import UIKit

class IncomeTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setData(amount: Amounts) {
        titleLabel.text = amount.title ?? ""
        subTitleLabel.text = "Remaining".localized + ": " + (amount.remain_amount ?? "")
        amountLabel.text = "Total".localized + ": " + (amount.amountNet ?? "")
        dateLabel.text = amount.date ?? ""
    }

}
