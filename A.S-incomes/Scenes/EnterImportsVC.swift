//
//  EnterImportsVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import UIKit

class EnterImportsVC: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var amount: Amounts?
   
    private lazy var loader: UIView = {
        return createActivityIndicator()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    private func resetFields() {
        amountTextField.text  = ""
        descriptionTextField.text = ""
        dateTextField.text = ""
    }
    
    private func setData() {
        guard let amount = amount else {
            return
        }
        amountTextField.text = amount.amountNet ?? ""
        descriptionTextField.text = amount.title ?? ""
        dateTextField.text = amount.date ?? ""
    }
    
    private func sendNewAmount(price: Double, desc: String, date: String) {
        loader.isHidden = false
        let id = UserManager.shared.getUserData().id
        APIRoute.shared.fetchRequest(clientRequest: .insertNewAmount(amount: price, title: desc, date: date, userId: id), decodingModel: FlagMessageResponse.self) { [weak self] result in
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
    
    private func updateAmount(price: Double, desc: String, date: String) {
        guard let amount = amount, let idTxt = amount.id, let amountId = Int(idTxt) else { return }
        loader.isHidden = false
        let id = UserManager.shared.getUserData().id
        APIRoute.shared.fetchRequest(clientRequest: .updateIncome(id: amountId, amount: price, title: desc, date: date, userId: id), decodingModel: FlagMessageResponse.self) { [weak self] result in
            guard let strongSelf = self else { return}
            strongSelf.loader.isHidden = true
            switch result {
            case .success(let data):
                strongSelf.navigationController?.popViewController(animated: true)
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
    
    @IBAction func sendAction(_ sender: Any) {
        guard let amountText = amountTextField.text, let desc = descriptionTextField.text, let price = Double(amountText) else {
            windows?.make(toast: "Insert values in all fields".localized)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = dateFormatter.string(from: datePicker.date)
        
        if date.isEmpty {
            date = dateFormatter.string(from: Date())
        }
        
        if amount != nil {
            updateAmount(price: price, desc: desc, date: date)
        }else {
            sendNewAmount(price: price, desc: desc, date: date)
        }
    }
}
