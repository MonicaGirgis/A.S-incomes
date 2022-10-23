import Foundation
import UIKit
import xlsxwriter

class Database {
    var bondList: [Bond] = []
    
    init(list: [Bond]) {
        bondList = list
    }
}

final class ExportXlsxService {
    
    let filename = "export_database.xlsx"
//    let cell_width: Double = 11.5
//    let cell_height: Double = 14.25

    var workbook: UnsafeMutablePointer<lxw_workbook>?
    var worksheet: UnsafeMutablePointer<lxw_worksheet>?
    var worksheet2: UnsafeMutablePointer<lxw_worksheet>?
    var format_header: UnsafeMutablePointer<lxw_format>?
    var format_1: UnsafeMutablePointer<lxw_format>?
    
    private var writingLine: UInt32 = 0
    private var needWriterPreparation = false
    
    init() {
        prepareXlsWriter()
    }
    
    /// Get the sandbox directory
    private func docDirectoryPath() -> String{
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)
        return dirPaths[0]
    }
    
    /// Prepare the xlsx objects
    private func prepareXlsWriter() {
        print("open \(docDirectoryPath())")
        var destination_path = docDirectoryPath()
        destination_path.append(filename)
        workbook = workbook_new(destination_path)
        worksheet = workbook_add_worksheet(workbook, nil)
        worksheet2 = workbook_add_worksheet(workbook, nil)
        // Add style
//        let format_right_to_left = workbook.add_format({"reading_order": 2})
        format_header = workbook_add_format(workbook)
        format_set_bold(format_header)
        format_set_border(format_header, 1)
        format_1 = workbook_add_format(workbook)
        format_set_border(format_1, 1)
        needWriterPreparation = false
    }
    
//    private func minRatio(left: (Double, Double), right: (Double, Double)) -> Double {
//        min(left.0 / right.0, left.1 / right.1)
//    }
    
//    /// Update NSData to buffer for xlsxwriter
//    private func getArrayOfBytesFromImage(imageData: NSData) -> [UInt8] {
//        //Determine array size
//        let count = imageData.length / MemoryLayout.size(ofValue: UInt8())
//        //Create an array of the appropriate size
//        var bytes = [UInt8](repeating: 0, count: count)
//        //Copy image data as bytes into the array
//        imageData.getBytes(&bytes, length:count * MemoryLayout.size(ofValue: UInt8()))
//
//        return bytes
//    }
    
    /// The first line is the header, we use bold style, and we write the column titles
    private func buildHeader() {
        writingLine = 0
        let format = format_header
        format_set_bold(format)
        worksheet_write_string(worksheet, writingLine, 0, "تاريخ", format)
        worksheet_write_string(worksheet, writingLine, 1, "بيان", format)
        worksheet_write_string(worksheet, writingLine, 2, "منصرف", format)
        worksheet_write_string(worksheet, writingLine, 3, "وارد", format)
        worksheet_write_string(worksheet, writingLine, 4, "رصيد", format)
    }
    
    /// Create a line for a product, change the style for odd row
    private func buildNewLine(bond: Bond) {
        writingLine += 1
        let lineFormat = format_1
        worksheet_write_string(worksheet, writingLine, 0, "test date", lineFormat)
        let text = bond.exportTxt == "" ? bond.importTxt : bond.exportTxt
        worksheet_write_string(worksheet, writingLine, 1, text, lineFormat)
        worksheet_write_number(worksheet, writingLine, 2, bond.exportAmount?.doubleValue ?? 0.0, lineFormat)
        worksheet_write_number(worksheet, writingLine, 3, bond.importAmount?.doubleValue ?? 0.0, lineFormat)
        worksheet_write_number(worksheet, writingLine, 4, bond.treseauryAmount?.doubleValue ?? 0.0, lineFormat)
    }
    
    /// Create and write / overwrite the xlsx file
    func export(db: Database) {
        guard !db.bondList.isEmpty else {
            windows?.make(toast: "Something went wrong".localized)
            return
        }
        
        if(needWriterPreparation == true){
            prepareXlsWriter()
        }
        
        buildHeader()
    
        let list = db.bondList
        
        for product in list {
            buildNewLine(bond: product)
        }
    
        // Closing the workbook will save the xlsx file on the filesystem
        workbook_close(workbook)
        needWriterPreparation = true
    }
}
