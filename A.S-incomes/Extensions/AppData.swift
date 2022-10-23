//
//  AppData.swift
//  TATX
//
//  Created by Mohammed Ragab on 12/11/18.
//  Copyright © 2018 TATX. All rights reserved.
//

import UIKit

let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let windows = windowScene?.windows.first
let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
let asyncPaymentCompletedNotificationKey = "AsyncPaymentCompletedNotificationKey"
