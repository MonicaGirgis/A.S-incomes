//
//  AppData.swift
//  TATX
//
//  Created by Mohammed Ragab on 12/11/18.
//  Copyright © 2018 TATX. All rights reserved.
//

import UIKit

let AppName = "Nyqat"
let PUSHER_KEY = "5fc0d90e10f73191c8bd"
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let windows = windowScene?.windows.first
let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
let asyncPaymentCompletedNotificationKey = "AsyncPaymentCompletedNotificationKey"
let paymentMethods : [String] = ["apple", "mada", "visa", "stc", "cash"]
let payment_brands = [[""], ["MADA"], ["VISA", "MASTER"], [ "STC_PAY"], [""]]
//let orderTypes : [String] = ["Delivery".localized, "Takeaway".localized]
let orderStatuses = ["new","preparing","ready","delivering","cancelled","refunded","completed"]
var deviceTokenString = "Constants.string.noDevice"
var device_id = UUID().uuidString
let googleMapKey = "AIzaSyDjj_1MEVHmWBJMVGuGklQOJbeO99CXsEI"//AIzaSyAMyyDYaMPdHoTWGo93dTthvqQ-rqJclHE"
let appSecretKey = "GgeSg5mscgv1QYMB0buYnSBUaPQfKChKrJxPs4JV"//"lbN7VMwLxs0yhiCGsZOLCne6NfcRbi6AdvWLGeEX"
let appClientId = 2
let defaultMapLocation = LocationCoordinate(latitude: 26.4207, longitude: 50.0888)
let locationApi = "https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@"
let passwordLengthMax = 10
//let distanceType = "km".localized
let requestCheckInterval : TimeInterval = 5
var supportNumber = "+966547130120"
let shopperResultURL = "com.app.Tatx.payments://result"
let shopperResultURLApplePay = "merchant.com.tatx"
let paymentURL = "com.app.Tatx.payments"
//let shopperResultURLApplePay = "merchant.48F73HZZ4P"
var supportEmail = "support@tatx.com"
var offlineNumber = "+966547130120"
let stripePublishableKey = "pk_test_0G4SKYMm8dK6kgayCPwKWTXy"
let helpSubject = "\(AppName) Help"
let driverUrl = "https://itunes.apple.com/us/app/"
let requestInterval : TimeInterval = 60  // seconds
let MAX_QTY : Int = 100
var ULng: Double = 50.0888
var ULat: Double = 26.4207
var MIN_CHARGE_AMOUNT :Double = 5
var pusherAppKey = "5fc0d90e10f73191c8bd"
var broadcasting = "https://apis.tatx.com/broadcasting/auth"
