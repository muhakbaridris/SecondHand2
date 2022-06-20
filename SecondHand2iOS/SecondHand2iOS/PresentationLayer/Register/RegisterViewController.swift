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
        self.hideKeyboardWhenTappedAround()
        self.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple4")
        buttonDaftarOutlet.layer.cornerRadius = 5
        
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
            CustomToast.show(message: "Lengkapi Data", bgColor: .systemRed, textColor: .white, labelFont: .systemFont(ofSize: 17), showIn: .bottom, controller: self)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "RegisterViewController", bundle:nil)
            let daftarLengkap = storyBoard.instantiateViewController(withIdentifier: "DaftarLengkap")
            self.navigationController?.pushViewController(daftarLengkap, animated: true)
        }
    }

    @IBAction func keHalamanMasukTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
        
}
