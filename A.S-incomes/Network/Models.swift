//
//  Models.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 23/05/2022.
//

import Foundation
import UIKit

struct FlagMessageResponse : Decodable {
    var error_flag : Int?
    var message : String?
}

struct Response<T : Decodable> : Decodable {
    var error_flag : Int?
    var message : String?
    var result: T?
}

struct Pagination : Codable {
    let total : Int?
    let count : Int?
    let per_page : ValueWrapper?
    let current_page : Int?
    let total_pages : Int?
}

struct PaginationResponse<T : Decodable> : Decodable {
    var data : [T]?
    var pagination : Pagination?
}
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
struct IdName: Codable, Hashable{
    let id : ValueWrapper?
    let name : String?
}

struct LocationObj :Codable, Hashable {
    let id : Int?
    let name, name_ar, name_en : String?
    let region_id : Int?
    let city_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case region_id = "region_id"
        case city_id = "city_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .name_ar) : try? values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
    }
}

// // MARK: - User
class User: Codable{
    let id: ValueWrapper?
    let profile: Account?
    let access_token: String?
}

// // MARK: - Account
class Account: Codable {
    let id, store_id: ValueWrapper?
    let image: String?
    let name : String?
    let mobile : String?
    let email : String?
}

// MARK: - Document
struct Document: Codable {
    let id : ValueWrapper?
    let name_ar : String?
    let name_en : String?
    let name : String?
    let is_required : ValueWrapper?
    let document_type : String?
    var image: Data?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case is_required = "is_required"
        case document_type = "document_type"
        case name, image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        name = try Language.getCurrentLanguage() == "ar" ? values.decodeIfPresent(String.self, forKey: .name_ar) : values.decodeIfPresent(String.self, forKey: .name_en)
        is_required = try values.decodeIfPresent(ValueWrapper.self, forKey: .is_required)
        document_type = try values.decodeIfPresent(String.self, forKey: .document_type)
        image = try values.decodeIfPresent(Data.self, forKey: .image)
    }
}

// // MARK: - User Model
struct UserModel{
    var package: String?
    var name, store_name : String?
    var mobile, email : String?
    var branchesCount: Int?
    var storeAddress: String?
    var lat, lng: String?
    var sub_domain: String?
    var module: Module?
    var form_step: Int?
    var password: String?
    var documents: [Document]?
}

// MARK: - ProductModel
struct ProductModel {
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var barcode: String?
    var source: String?
    var descAr: String?
    var descEn: String?
    var qty: Int?
    var price: Double?
    var prodDate: String?
    var expDate: String?
    var branch: Branch?
    var product: Product?
    var store: Store?
    var image: Data?
    var categories: [Category]?
}


// MARK: - Module
struct Module: Codable {
    let id : ValueWrapper?
    let name_ar : String?
    let name_en : String?
    let name: String?
    let module_type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case module_type = "module_type"
        case name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        name = try Language.getCurrentLanguage() == "ar" ? values.decodeIfPresent(String.self, forKey: .name_ar) : values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        module_type = try values.decodeIfPresent(String.self, forKey: .module_type)
    }
}

// // MARK: - Category
struct Category: Codable{
    let id : ValueWrapper?
    let supplier_id : ValueWrapper?
    let name, name_ar, name_en : String?
    let desc, desc_ar, desc_en : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case supplier_id = "supplier_id"
        case image = "image"
        case name, name_ar, name_en
        case desc, desc_ar, desc_en
    }
    
    init(from decoder: Decoder) throws {
        let Values = try decoder.container(keyedBy: CodingKeys.self)
        id = try Values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        image = try Values.decodeIfPresent(String.self, forKey: .image)
        supplier_id = try Values.decodeIfPresent(ValueWrapper.self, forKey: .supplier_id)
        name = (Language.getCurrentLanguage() == "ar") ? try? Values.decodeIfPresent(String.self, forKey: .name_ar) : try? Values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try Values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try Values.decodeIfPresent(String.self, forKey: .name_en)
        desc = (Language.getCurrentLanguage() == "ar") ? try? Values.decodeIfPresent(String.self, forKey: .desc_ar) : try? Values.decodeIfPresent(String.self, forKey: .desc_en)
        desc_ar = try Values.decodeIfPresent(String.self, forKey: .desc_ar)
        desc_en = try Values.decodeIfPresent(String.self, forKey: .desc_en)
    }
    
    init(name: String){
        self.id = nil
        self.name_en = nil
        self.name_ar = nil
        self.desc = nil
        self.desc_ar = nil
        self.desc_en = nil
        self.image = nil
        self.supplier_id = nil
        
        self.name = name
    }
}

// // MARK: - Product
class Product: NSObject, Codable{
    let id : ValueWrapper?
    let barcode : String?
    let name ,name_ar, name_en : String?
    let desc, desc_ar, desc_en : String?
    let price : ValueWrapper?
    let qty : ValueWrapper?
    let sku : String?
    let prod_date : String?
    let exp_date : String?
    let store_id : String?
    let image : String?
    let images : [String]?
    let supplier : IdName?
    let brand : String?
    let category : Category?
    let sub_category : IdName?
    let is_active : ValueWrapper?
    let imgData: Data?
    
    var selectedQty: Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case desc_ar = "desc_ar"
        case desc_en = "desc_en"
        case price = "price"
        case qty = "qty"
        case sku = "sku"
        case prod_date = "prod_date"
        case exp_date = "exp_date"
        case store_id = "store_id"
        case image = "image"
        case images = "images"
        case supplier = "supplier"
        case brand = "brand"
        case category = "category"
        case sub_category = "sub_category"
        case selectedQty, is_active, barcode, imgData
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        name = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .name_ar) : try? values.decodeIfPresent(String.self, forKey: .name_en)
        desc_ar = try values.decodeIfPresent(String.self, forKey: .desc_ar)
        desc_en = try values.decodeIfPresent(String.self, forKey: .desc_en)
        desc = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .desc_ar) : try? values.decodeIfPresent(String.self, forKey: .desc_en)
        price = try values.decodeIfPresent(ValueWrapper.self, forKey: .price)
        qty = try values.decodeIfPresent(ValueWrapper.self, forKey: .qty)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        prod_date = try values.decodeIfPresent(String.self, forKey: .prod_date)
        exp_date = try values.decodeIfPresent(String.self, forKey: .exp_date)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        supplier = try values.decodeIfPresent(IdName.self, forKey: .supplier)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
        sub_category = try values.decodeIfPresent(IdName.self, forKey: .sub_category)
        selectedQty = try values.decodeIfPresent(Int.self, forKey: .selectedQty)
        is_active = try values.decodeIfPresent(ValueWrapper.self, forKey: .is_active)
        imgData = try values.decodeIfPresent(Data.self, forKey: .imgData)
    }
    
    required init(id: ValueWrapper, name: String, price: ValueWrapper, image: Data){
        self.desc = nil
        self.desc_ar = nil
        self.desc_en = nil
        self.qty = ValueWrapper("100")
        self.selectedQty = 1
        self.sku = nil
        self.prod_date = nil
        self.exp_date = nil
        self.store_id = nil
        self.image = nil
        self.images = nil
        self.supplier = nil
        self.brand = nil
        self.category = nil
        self.sub_category = nil
        self.barcode = nil
        self.is_active = nil
        
        self.id = id
        self.name_en = name
        self.name_ar = name
        self.name = name
        self.price = price
        self.imgData = image
    }
}

// MARK: - Cart
class Cart: NSObject, Codable{
    let id: String?
    var products: [Product]
    var total, deliveryFees, vat, subTotal: Double
    var isActive: Bool?
    
    init(id: String){
        self.id = id
        total = 0.0
        deliveryFees = 0.0
        vat = 0.0
        subTotal = 0.0
        products = []
    }
}

// MARK: -  Store
struct Store: Codable {
    let id : ValueWrapper?
    let logo : String?
    let name_ar, name_en, name : String?
    let is_active : Int?
    let address : String?
    let lat : ValueWrapper?
    let lng : ValueWrapper?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case logo = "logo"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case is_active = "is_active"
        case name, address, lat, lng
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        name = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .name_ar) : try? values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        is_active = try values.decodeIfPresent(Int.self, forKey: .is_active)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(ValueWrapper.self, forKey: .lat)
        lng = try values.decodeIfPresent(ValueWrapper.self, forKey: .lng)
    }
}

// MARK: - Branch
struct Branch: Codable {
    let id : ValueWrapper?
    let name_ar, name_en, name : String?
    let region : String?
    let city : String?
    let district : String?
    let address : String?
    let lat : ValueWrapper?
    let lng : ValueWrapper?
    let store : Store?
    let commercial_register_num : String?
    let commercial_register_image : String?
    let commercial_register_date : String?
    let is_active : ValueWrapper?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case region = "region"
        case city = "city"
        case district = "district"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
        case store = "store"
        case commercial_register_num = "commercial_register_num"
        case commercial_register_image = "commercial_register_image"
        case commercial_register_date = "commercial_register_date"
        case is_active = "is_active"
        case name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        name = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .name_ar) : try? values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        district = try values.decodeIfPresent(String.self, forKey: .district)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(ValueWrapper.self, forKey: .lat)
        lng = try values.decodeIfPresent(ValueWrapper.self, forKey: .lng)
        store = try values.decodeIfPresent(Store.self, forKey: .store)
        commercial_register_num = try values.decodeIfPresent(String.self, forKey: .commercial_register_num)
        commercial_register_image = try values.decodeIfPresent(String.self, forKey: .commercial_register_image)
        commercial_register_date = try values.decodeIfPresent(String.self, forKey: .commercial_register_date)
        is_active = try values.decodeIfPresent(ValueWrapper.self, forKey: .is_active)
    }
}

// MARK: - Warehouses
struct Warehouse: Codable {
    let id : ValueWrapper?
    let name_ar : String?
    let name_en : String?
    let name: String?
    let region : LocationObj?
    let city : LocationObj?
    let district : LocationObj?
    let address : String?
    let lat : ValueWrapper?
    let lng : ValueWrapper?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case region = "region"
        case city = "city"
        case district = "district"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ValueWrapper.self, forKey: .id)
        name = (Language.getCurrentLanguage() == "ar") ? try? values.decodeIfPresent(String.self, forKey: .name_ar) : try? values.decodeIfPresent(String.self, forKey: .name_en)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        region = try values.decodeIfPresent(LocationObj.self, forKey: .region)
        city = try values.decodeIfPresent(LocationObj.self, forKey: .city)
        district = try values.decodeIfPresent(LocationObj.self, forKey: .district)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(ValueWrapper.self, forKey: .lat)
        lng = try values.decodeIfPresent(ValueWrapper.self, forKey: .lng)
    }
}

// MARK: - Order
struct Order: Codable {
    let id : ValueWrapper?
    let checkout_id : String?
    let warehouse : Warehouse?
    let store : Store?
    let sub_total : ValueWrapper?
    let shipping_fees : ValueWrapper?
    let vat : ValueWrapper?
    let coupon : String?
    let coupon_discount : ValueWrapper?
    let total : ValueWrapper?
    let status : String?
    let is_closed : ValueWrapper?
    let payment_method : String?
    let payment_option : String?
    let payment_status : String?
    let notes : String?
    let shipping_region : String?
    let shipping_city : String?
    let shipping_district : String?
    let shipping_address : String?
    let products : [Product]?
    let created_at: String?
}

// MARK: - Customer
struct Customer: Codable {
    let id : ValueWrapper?
    let name : String?
    let email : String?
    let mobile : String?
    let gender : String?
    let store : Store?
    let is_active : ValueWrapper?
}

// MARK: - My Store Categories
struct CategoriesResponse: Decodable {
    let categories: [Category]?
}

// MARK: - Stores Response
struct StoresResponse: Decodable {
    let stores: [Store]
}

//  MARK: - Store Products
struct ProductsResponse: Decodable {
    let products: PaginationResponse<Product>?
}

//  MARK: - Store Products
struct AllProductsResponse: Decodable {
    let products: [Product]
}

//  MARK: - Register Documents
struct DocumentsResponse: Decodable {
    let documents: [Document]
}

// MARK: - Modules Response
struct ModulesResponse: Decodable {
    let modules: [Module]
}

// MARK: - Branches Response
struct BranchesResponse: Decodable {
    let branches: [Branch]
}

// MARK: - Warehouses Response
struct WarehousesResponse: Decodable {
    let warehouses : [Warehouse]?
}

// MARK: - Orders Response
struct OrdersResponse: Decodable {
    let orders: PaginationResponse<Order>
}

// MARK: - Customers Response
struct CustomersResponse: Decodable {
    let customers: PaginationResponse<Customer>
}

// MARK: - Create Order
class CreateOrder {

    var warehouse: Warehouse?
    var paymentOption: String?
    
    required init(warehouse: Warehouse, paymentOption: String) {
        self.warehouse = warehouse
        self.paymentOption = paymentOption
    }
    
    func getNewPurchaseParams()->[String: Any] {
        var params: [String:Any] = [:]
        guard let warehouse = warehouse, let paymentOption = paymentOption else {
            return params
        }
        params["warehouse_id"] = warehouse.id?.intValue ?? 0
        params["store_id"] = UserManager.shared.getStore()?.id?.intValue ?? 0
        params["payment_option"] = paymentOption
        
        var products: [Product] = []
        products.loadCart("MyCart")
        
        for (i,n) in products.enumerated() {
            params["products[\(i)][id]"] = n.id?.intValue ?? 0
            params["products[\(i)][qty]"] = n.selectedQty ?? 1
        }
         return params
    }
    
    class func clearCart(_ cart_id: String){
        var items = [Product]()
        items.loadCart(cart_id)
        items.removeAll()
        let itemData = try! JSONEncoder().encode(items)
        UserDefaults.standard.set(itemData, forKey: cart_id)
        UserDefaults.standard.set(nil, forKey:  cart_id)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Create Invoice
class CreateInvoice {

    var mobile: String?
    var name: String?
    var paymentOption: String?
    
    required init(mobile: String, name: String, paymentOption: String) {
        self.mobile = mobile
        self.name = name
        self.paymentOption = paymentOption
    }
    
    func getInvoiceParams(from id: String)->[String: Any] {
        var params: [String:Any] = [:]
        guard let mobile = mobile, let paymentOption = paymentOption, let name = name else {
            return params
        }
        params["customer_name"] = name
        params["customer_mobile"] = mobile
        params["payment_method"] = paymentOption
        
        var products: [Product] = []
        products.loadCart(id)
        
        for (i,n) in products.enumerated() {
            params["products[\(i)][id]"] = n.id?.intValue ?? 0
            params["products[\(i)][qty]"] = n.selectedQty ?? 1
        }
         return params
    }
    
    class func clearCart(_ cart_id: String){
        var items = [Product]()
        items.loadCart(cart_id)
        items.removeAll()
        let itemData = try! JSONEncoder().encode(items)
        UserDefaults.standard.set(itemData, forKey: cart_id)
        UserDefaults.standard.set(nil, forKey:  cart_id)
        UserDefaults.standard.synchronize()
    }
}
