//
//  UbahPasswordViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 09/07/22.
//

import UIKit

final class UbahPasswordViewController: UIViewController {
    
    let callAuthAPI = SHAuthAPI()
    var access_token: String = ""
    
    @IBOutlet weak var passwordLamaTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordBaruTextFieldOutlet: UITextField!
    @IBOutlet weak var ulangPasswordBaruTextFieldOutlet: UITextField!
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSimpanOutlet.layer.cornerRadius = 16
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print(UserDefaults.standard.string(forKey: "access_token")!)
        }
    }
    
    @IBAction func buttonSimpanPasswordTapIn(_ sender: Any) {
        if passwordLamaTextFieldOutlet.text?.isEmpty == true || passwordBaruTextFieldOutlet.text?.isEmpty == true || ulangPasswordBaruTextFieldOutlet.text?.isEmpty == true {
            CustomToast.show(message: "Lengkapi Password",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            let changePassword = ChangePasswordModel(
                current_password: passwordLamaTextFieldOutlet.text!,
                new_password: passwordBaruTextFieldOutlet.text!,
                confirm_password: ulangPasswordBaruTextFieldOutlet.text!)
            
            callAuthAPI.changePasswordSecondHand(changePasswrdData: changePassword, access_token: access_token) { result in
                switch result {
                case let .success(data):
                    print(data.message)
                    if data.message == "Password is wrong." {
                        CustomToast.show(message: "Password Salah",
                                         bgColor: .systemRed,
                                         textColor: .white,
                                         labelFont: .systemFont(ofSize: 17),
                                         showIn: .bottom,
                                         controller: self)
                    } else {
                        CustomToast.show(message: "Berhasil Ubah Password",
                                         bgColor: .systemGreen,
                                         textColor: .white,
                                         labelFont: .systemFont(ofSize: 17),
                                         showIn: .bottom,
                                         controller: self)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                case let .failure(err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
