//
//  LoginVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 06/11/2022.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    
    private lazy var loader: UIView = {
        return createActivityIndicator()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func login(password: String, username: String) {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .login(name: username, password: password), decodingModel: User.self) { [weak self] result in
            guard let strongSelf = self else { return}
            switch result {
            case .success(let data):
                UserManager.shared.setUser(user: data)
                strongSelf.performSegue(withIdentifier: "show" + HomeVC.identifier, sender: nil)
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    @IBAction func loginAction() {
        guard let userName = userNameField.text, !userName.isEmpty, let pass = passwordField.text, !pass.isEmpty else { return}
        login(password: pass, username: userName)
    }
}
