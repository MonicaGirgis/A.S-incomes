//
//  EnterExpensesVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import UIKit

class EnterExpensesVC: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private lazy var loader: UIView = {
        return createActivityIndicator()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func resetFields() {
        amountTextField.text  = ""
        descriptionTextField.text = ""
        dateTextField.text = ""
    }
    
    private func sendNewAmount(amount: Double, desc: String, date: String) {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .insertNewAmount(amount: amount, title: desc, date: date), decodingModel: FlagMessageResponse.self) { [weak self] result in
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
    
    @IBAction func sendAction(_ sender: Any) {
        guard let amountText = amountTextField.text, let desc = descriptionTextField.text, let amount = Double(amountText) else {
            windows?.make(toast: "Insert values in all fields".localized)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = dateFormatter.string(from: datePicker.date)
        
        if date.isEmpty {
            date = dateFormatter.string(from: Date())
        }
        
        sendNewAmount(amount: amount, desc: desc, date: date)
    }
}
