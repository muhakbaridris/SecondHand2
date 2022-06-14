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
    @IBOutlet weak var showPasswordButtonOutlet: UIButton!
    @IBOutlet weak var masukButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        masukButtonOutlet.layer.cornerRadius = 5
        
    }
    
    @IBAction func showhidePasswordTapIn(_ sender: Any) {
        passwordTextFieldOutlet.togglePasswordVisibility()
        if passwordTextFieldOutlet.isSecureTextEntry == false {
            showPasswordButtonOutlet.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            showPasswordButtonOutlet.tintColor = UIColor(named: "Purple4")
        } else {
            showPasswordButtonOutlet.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            showPasswordButtonOutlet.tintColor = .systemGray2
        }
    }
    
    @IBAction func masukTapIn(_ sender: Any) {
        
    }
    
}
