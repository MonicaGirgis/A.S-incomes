//
//  ExportExcelVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 21/10/2022.
//

import UIKit
import QuickLook
import xlsxwriter

class ExportExcelVC: UIViewController {

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    private lazy var loader: UIView = {
       return createActivityIndicator()
    }()
    
    private lazy var previewItem = NSURL()
    private let dateFormatter = DateFormatter()
    
    private var data: [Bond] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchData(from: String, to: String) {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .exportExcel(from: from, to: to), decodingModel: Response<Bond>.self) { [weak self] result in
            guard let strongSelf = self else { return}
            strongSelf.loader.isHidden = true
            switch result {
            case .success(let data):
                if !data.data.isEmpty {
                    strongSelf.data = data.data
                    strongSelf.generateExcelFile(inQuickLook: false)
                }
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    private func generateFunction() -> URL{
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let fileURL = documentDirectory.appendingPathComponent("Bonds.xlsx")
        
        //Create a new workbook.
        //Ditch first 6 characters, because they are of the form file://
        let workbook = workbook_new((fileURL.absoluteString.dropFirst(6) as NSString).fileSystemRepresentation)
        
        let worksheet1 = workbook_add_worksheet(workbook, nil)
        let worksheet2 = workbook_add_worksheet(workbook, nil)
        
        // right to left sheet
        worksheet_right_to_left(worksheet1)
        worksheet_right_to_left(worksheet2)
        
        //Add some cell formats.
        let myformat1 = workbook_add_format(workbook)
        let myformat2 = workbook_add_format(workbook)
        let headerFormat = workbook_add_format(workbook)
        
        format_set_border(myformat1, 1)
        format_set_bold(headerFormat)
        format_set_border(headerFormat, 1)
        format_set_num_format(myformat2, "$#,##0.00")
        
        // text aligment
        format_set_align(myformat1, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(headerFormat, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(headerFormat, UInt8(LXW_ALIGN_VERTICAL_CENTER.rawValue))
        format_set_align(myformat2, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(myformat2, UInt8(LXW_ALIGN_VERTICAL_CENTER.rawValue))
        
        // set column width
        worksheet_set_column(worksheet1, 1, 1, 50, nil)
        worksheet_set_column(worksheet1, 0, 0, 12, nil)
        
        // set row height
        worksheet_set_row(worksheet1, 0, 25, nil)

        
        var writingLine: UInt32 = 0
        
        worksheet_write_string(worksheet1, writingLine, 0, "تاريخ", headerFormat)
        worksheet_write_string(worksheet1, writingLine, 1, "بيان", headerFormat)
        worksheet_write_string(worksheet1, writingLine, 2, "منصرف", headerFormat)
        worksheet_write_string(worksheet1, writingLine, 3, "وارد", headerFormat)
        worksheet_write_string(worksheet1, writingLine, 4, "رصيد", headerFormat)
        
        
        var temp: [String] = []
        data.forEach { bond in
            writingLine += 1
            let lineFormat = myformat1
    
            worksheet_write_string(worksheet1, writingLine, 0, bond.date ?? "", lineFormat)
            worksheet_write_string(worksheet1, writingLine, 1, bond.text ?? "", lineFormat)
            worksheet_write_number(worksheet1, writingLine, 2, bond.exportAmount?.doubleValue ?? 0.0, lineFormat)
            worksheet_write_number(worksheet1, writingLine, 3, bond.importAmount?.doubleValue ?? 0.0, lineFormat)
            worksheet_write_number(worksheet1, writingLine, 4, bond.treseauryAmount?.doubleValue ?? 0.0, lineFormat)
            
            
            if let firstIndex = data.firstIndex(where: { $0.date == bond.date }), let endIndex = data.lastIndex(where: { $0.date == bond.date }),  firstIndex < endIndex, !temp.contains(where: { $0 == bond.date }) {
                temp.append(data[firstIndex].date ?? "")
                worksheet_merge_range(worksheet1, UInt32(firstIndex + 1) , 0, UInt32(endIndex + 1), 0, data[firstIndex].date ?? "", myformat2)
            }
        }
        
        
        worksheet_write_string(worksheet2, 0, 0, "Some text", myformat1)
        //Close the workbook, save the file and free any memory.
        let error = workbook_close(workbook)
        //Check if there was any error creating the xlsx file.
        if (error.rawValue != LXW_NO_ERROR.rawValue){
            print("Error in workbook_close().\nError %d = %s\n", error, lxw_strerror(error)!)
        }
        
        return fileURL
    }
    
    private func generateExcelFile(inQuickLook: Bool) {
        let fileUrl = generateFunction()
        if inQuickLook {
            displayExcelFile(fileUrl: fileUrl)
        }
        else{
            shareExcelFile(fileUrl: fileUrl)
        }
    }
    
    private func displayExcelFile(fileUrl: URL){
        let previewController = QLPreviewController()
        self.previewItem = fileUrl as NSURL
        
        previewController.dataSource = self
        self.present(previewController, animated: true)
        
        previewController.delegate = self
    }
    
    func previewControllerWillDismiss(_ controller: QLPreviewController){
        self.removeTemporaryFile(fileUrl: self.previewItem as URL)
    }
    
    private func shareExcelFile(fileUrl: URL) {
        var filesToShare = [Any]()
        filesToShare.append(fileUrl)
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)

        self.present(activityViewController, animated: true)
        
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            self.removeTemporaryFile(fileUrl: fileUrl)
            self.dismiss(animated: false, completion: nil) //File needs to be recreated; reflect in UI
        }
    }
    
    private func removeTemporaryFile(fileUrl: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: fileUrl)
        } catch {
            print("Could not delete temporary file: \(error)")
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

extension ExportExcelVC: QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem as QLPreviewItem
    }
}
