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
        return (getUserData().id ?? 0) != 0
    }
    
    func setUser(user: User) {
        UserDefaults.standard.set(user.id ?? -1, forKey: "userId")
        UserDefaults.standard.set(user.type ?? "", forKey: "userType")
    }
    
    func getUserData() -> User {
        let id = UserDefaults.standard.integer(forKey: "userId")
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
