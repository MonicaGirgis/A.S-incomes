//
//  CardView.swift
//  Tatx
//
//  Created by Monica Girgis Kamel on 30/01/2022.
//

import Foundation
import UIKit

class CardView: UIView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        self.makeRoundedCornersWith(radius: 8.0)
        self.makeBorders(borderColor: UIColor(hex: 0xD0D0D0))
    }
}

class RoundedCornersView: UIView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundedCornersWith(radius: 8.0)
    }
}

class RoundedView: UIView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeRoundedCorners()
    }
}

class RoundedTextField: BaseTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        self.makeRoundedCornersWith(radius: 8.0)
        self.makeBorders(borderColor: UIColor(hex: 0xD0D0D0))
    }
}
