//
//  LoginViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var buttonShowPasswordOutlet: UIButton!
    @IBOutlet weak var buttonMasukOutlet: UIButton!
    
    let callAPI = SHAuthAPI()
    var loginResponse: [LoginResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        buttonMasukOutlet.layer.cornerRadius = 16
        self.hideKeyboardWhenTappedAround() 
        self.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple4")
    }
    
    @IBAction func showhidePasswordTapIn(_ sender: Any) {
        passwordTextFieldOutlet.isSecureTextEntry = !passwordTextFieldOutlet.isSecureTextEntry
        if passwordTextFieldOutlet.isSecureTextEntry == false {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = UIColor(named: "Purple4")
        } else {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = .systemGray2
        }
    }
    
    @IBAction func buttonMasukTapIn(_ sender: Any) {
        print("Tap Button Masuk")
        if emailTextFieldOutlet.text?.isEmpty == true || passwordTextFieldOutlet.text?.isEmpty == true {
            CustomToast.show(message: "Lengkapi Data", bgColor: .systemRed, textColor: .white, labelFont: .systemFont(ofSize: 17), showIn: .bottom, controller: self)
        } else {
            let loginData = LoginModel(email: emailTextFieldOutlet.text!, password: passwordTextFieldOutlet.text!)
            callAPI.loginUserSecondHand(login: loginData) { result in
                switch result {
                case let .success(data):
                    self.loginResponse.append(data)
//                    print("Hasilnya \(self.loginResponse)")
                case let .failure(err):
                    print(err.localizedDescription)
                }
            }
        }
        
        
    }
    
}
