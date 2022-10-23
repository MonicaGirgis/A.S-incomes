//
//  ExportExcelVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 21/10/2022.
//

import UIKit
import xlsxwriter

class ExportExcelVC: UIViewController {

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    private lazy var loader: UIView = {
       return createActivityIndicator()
    }()
    
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    private func fetchData(from: String, to: String) {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .exportExcel(from: from, to: to), decodingModel: Response<Bond>.self) { [weak self] result in
            guard let strongSelf = self else { return}
            strongSelf.loader.isHidden = true
            switch result {
            case .success(let data):
                if !data.data.isEmpty {
                    let db = Database(list: data.data)
                    ExportXlsxService().export(db: db)
                }
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    @IBAction func fromDateChanged(_ sender: UIDatePicker) {
        fromTextField.text = dateFormatter.string(from: fromDatePicker.date)
    }
    
    @IBAction func toDateChanged(_ sender: UIDatePicker) {
        toTextField.text = dateFormatter.string(from: toDatePicker.date)
    }
    
    @IBAction func exportAction(_ sender: Any) {
        let fromDate = dateFormatter.string(from: fromDatePicker.date)
        let toDate = dateFormatter.string(from: toDatePicker.date)
        fetchData(from: fromDate, to: toDate)
    }
}
