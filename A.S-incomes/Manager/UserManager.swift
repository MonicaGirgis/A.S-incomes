//
//  UserManager.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import Foundation

class UserManager{
    
    public static let shared = UserManager()
    private init(){}
    
    
    // check if user is logged in
    func isUserLoggedIn()-> Bool{
        return getAuthorizationKey() != nil 
    }
    
    // MARK: - Auth key
    func setAuthenticationKey(key: String){
        UserDefaults.standard.set(key, forKey: "USERTOKEN")
    }
    func getAuthorizationKey() -> String?{
        return UserDefaults.standard.string(forKey: "USERTOKEN")
    }

    func clearData(){
        UserDefaults.standard.removeObject(forKey: "USER")
    }
}
