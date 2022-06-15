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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonDaftarOutlet.layer.cornerRadius = 5
        self.hideKeyboardWhenTappedAround()
        self.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple4")
        
        
    }
    
    @IBAction func showhidePasswordTapIn(_ sender: Any) {
        buatPasswordTextFieldOutlet.togglePasswordVisibility()
        if buatPasswordTextFieldOutlet.isSecureTextEntry == false {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = UIColor(named: "Purple4")
        } else {
            buttonShowPasswordOutlet.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            buttonShowPasswordOutlet.tintColor = .systemGray2
        }
    }
    
    @IBAction func keHalamanMasukTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
