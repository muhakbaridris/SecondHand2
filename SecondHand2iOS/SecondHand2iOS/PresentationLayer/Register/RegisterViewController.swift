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
            let inputRegisterData = RegisterModelMini(full_name: buatNamaTextFieldOutlet.text!,
                                                      email: buatEmailTextFieldOutlet.text!,
                                                      password: buatPasswordTextFieldOutlet.text!)
            callAPI.registerUserSecondHand(registerData: inputRegisterData) { result in
                switch result {
                case let .success(data):
                    print("result \(data)")
                    let loginData = LoginModel(email: self.buatEmailTextFieldOutlet.text!,
                                               password: self.buatPasswordTextFieldOutlet.text!)
                    self.callAPI.loginUserSecondHand(login: loginData) { result in
                        switch result {
                        case let .success(data):
                            AccessTokenCache.save(data.access_token)
                            CustomToast.show(message: "Anda berhasil daftar\nSilahkan lengkapi data akun anda.",
                                             bgColor: .systemGreen,
                                             textColor: .white,
                                             labelFont: .systemFont(ofSize: 17),
                                             showIn: .bottom,
                                             controller: self)
                            let viewController = UIStoryboard(name: "RegisterViewController",
                                                              bundle: nil)
                                .instantiateViewController(withIdentifier: "RegisterFullViewController") as! RegisterFullViewController
                            viewController.namaTerdaftar = data.name
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                let navBar = UINavigationController(rootViewController: viewController)
                                navBar.modalPresentationStyle = .fullScreen
                                self.present(navBar, animated: true)
                            }
                        case let .failure(err):
                            print(err.localizedDescription)
                        }
                    }
                    
                case .failure(let err):
                    print("errornya \(err.localizedDescription)")
                    CustomToast.show(message: "Email dan Password salah atau sudah terpakai.",
                                     bgColor: .systemRed,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                }
            }
        }
    }
}
