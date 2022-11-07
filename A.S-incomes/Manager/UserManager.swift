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
        return (getUserData().id ?? "") != ""
    }
    
    func setUser(user: User) {
        UserDefaults.standard.set(user.id ?? "", forKey: "userId")
        UserDefaults.standard.set(user.type ?? "", forKey: "userType")
    }
    
    func getUserData() -> User {
        let id = UserDefaults.standard.string(forKey: "userId") ?? ""
        let type = UserDefaults.standard.string(forKey: "userType") ?? ""
        return User(id: id, type: type)
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
