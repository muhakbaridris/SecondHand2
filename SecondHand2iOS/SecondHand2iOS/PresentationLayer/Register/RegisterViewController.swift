//
//  RegisterViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class RegisterViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonMasukTapIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
