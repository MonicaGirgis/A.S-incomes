//
//  BaseTabBar.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 21/10/2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController , UITabBarControllerDelegate {
    
    let tabBarItemsNames = ["Home","Insert Expense","Export Excel"]
    let tabBarItemsImages = [UIImage(systemName: "homekit") ?? UIImage(),
                             UIImage(systemName: "pencil.and.ellipsis.rectangle") ?? UIImage(),
                             UIImage(systemName: "tray.full") ?? UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup(){
        var x = 0
        for item in tabBar.items!
        {
            item.image = tabBarItemsImages[x]
            item.title = tabBarItemsNames[x].localized
            x = x + 1
        }
    }
}
