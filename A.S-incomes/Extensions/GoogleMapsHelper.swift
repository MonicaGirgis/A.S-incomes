//
//  GoogleMapsHelper.swift
//  User
//
//  Created by MacBookPro on 09/05/18.
//  Copyright © 2018 Ragab Mohammed. All rights reserved.
//

import Foundation
//import GoogleMaps
import MapKit

typealias LocationCoordinate = CLLocationCoordinate2D
typealias LocationDetail = (address : String, coordinate :LocationCoordinate)

private struct Place : Decodable {
    var results : [GAddress]?
    
}

private struct GAddress : Decodable {
    
    var formatted_address : String?
    var geometry : Geometry?
}

private struct Geometry : Decodable {
    var location : GLocation?
    
}

private struct GLocation : Decodable {
    var lat : Double?
    var lng : Double?
}
