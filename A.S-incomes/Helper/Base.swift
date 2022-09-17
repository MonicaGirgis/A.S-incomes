//
//  Base.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import Foundation
import UIKit

class BaseTextField: UITextField{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = .white
        placeholder = placeholder?.localized
    }
}

class BaseLabel: UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        text = text?.localized
    }
}

class BaseButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        let title = titleLabel?.text
        setTitle(title?.localized, for: .normal)
    }
}
