//
//  RegisterViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class RegisterViewController: UIViewController{
    
    @IBOutlet weak var buatNamaTextFieldOutlet: UITextField!
    @IBOutlet weak var buatEmailTextFieldOutlet: UITextField!
    @IBOutlet weak var buatPasswordTextFieldOutlet: UITextField!
    @IBOutlet weak var buttonShowPasswordOutlet: UIButton!
    @IBOutlet weak var buttonDaftarOutlet: UIButton!
    
    let callAPI = SHAuthAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple4")
        buttonDaftarOutlet.layer.cornerRadius = 16
        
    }
    
    @IBAction func showhidePasswordTapIn(_ sender: Any) {
        buatPasswordTextFieldOutlet.isSecureTextEntry = !buatPasswordTextFieldOutlet.isSecureTextEntry
        if buatPasswordTextFieldOutlet.isSecureTextEntry == false {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = UIColor(named: "Purple4")
        } else {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = .systemGray2
        }
    }
    
    @IBAction func keHalamanDaftarFullTapIn(_ sender: Any) {
        if buatNamaTextFieldOutlet.text?.isEmpty == true ||
           buatEmailTextFieldOutlet.text?.isEmpty == true ||
           buatPasswordTextFieldOutlet.text?.isEmpty == true ||
           buatEmailTextFieldOutlet.text?.isValidEmail() == false {
            CustomToast.show(message: "Lengkapi Data",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            callAPI.registerUserSecondHand(full_name: buatNamaTextFieldOutlet.text!,
                                           email: buatEmailTextFieldOutlet.text!,
                                           password: buatPasswordTextFieldOutlet.text!) { result in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
