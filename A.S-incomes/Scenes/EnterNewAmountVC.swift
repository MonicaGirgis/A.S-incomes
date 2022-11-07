//
//  EnterNewAmountVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 27/10/2022.
//

import UIKit
import DropDown

class EnterNewAmountVC: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var menuView: UIView!
    
    var amount: Amounts?
    
    private var destinations: [Destination] = []
    private var allDestinations: [Destination] = []
    
    private lazy var loader: UIView = {
        return createActivityIndicator()
    }()
    
    var menu: DropDown = DropDown(){
        didSet{
            if Language.getCurrentLanguage() == "ar" {
                menu.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
                menu.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                        cell.optionLabel.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
                    }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Enter new amount".localized
        fetchData()
    }
    
    private func resetFields() {
        amountTextField.text  = ""
        descriptionTextView.text = ""
        dateTextField.text = ""
        destinationTextField.text = ""
    }
    
    private func fetchData() {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .getAllClients, decodingModel: Response<Destination>.self) { [weak self] result in
            self?.loader.isHidden = true
            switch result {
            case .success(let data):
                self?.allDestinations = data.data
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    private func sendNewAmount(price: Double, desc: String, date: String) {
        guard let idTxt = amount?.Id, let id = Int(idTxt) else { return}
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .insertExpensesDetails(amountId: id, amount: price, title: desc, date: date), decodingModel: FlagMessageResponse.self) { [weak self] result in
            guard let strongSelf = self else { return}
            strongSelf.loader.isHidden = true
            switch result {
            case .success(let data):
                strongSelf.resetFields()
                windows?.make(toast: data.message ?? "")
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: datePicker.date)
        
        dateTextField.text = date
    }
    
    @IBAction func destValueChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return}
        destinations = allDestinations.filter({ $0.name?.contains(text) ?? false })
        menu = {
            let menu = DropDown()
            menu.dataSource = destinations.map({ $0.name ?? "" })
            return menu
        }()
        menu.anchorView = menuView
        menu.selectionAction = { [weak self] index, title in
            self?.destinationTextField.text = title
        }
        menu.show()
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let amountText = amountTextField.text, let dest = destinationTextField.text, !dest.isEmpty, let price = Double(amountText) else {
            windows?.make(toast: "Insert values in all fields".localized)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = dateFormatter.string(from: datePicker.date)
        
        if date.isEmpty {
            date = dateFormatter.string(from: Date())
        }
        
        sendNewAmount(price: price, desc: dest, date: date)
    }

}
