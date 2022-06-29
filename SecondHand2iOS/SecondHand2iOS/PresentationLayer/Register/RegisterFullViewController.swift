//
//  RegisterFullViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 29/06/22.
//

import UIKit

final class RegisterFullViewController: UIViewController {
    
    @IBOutlet weak var addImageViewOutlet: UIImageView!
    @IBOutlet weak var namaTextFieldOutlet: UITextField!
    @IBOutlet weak var pilihKotaTextFieldOutlet: UITextField!
    @IBOutlet weak var alamatTextFieldOutlet: UITextField!
    @IBOutlet weak var nomorTextFieldOutlet: UITextField!
    
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSimpanOutlet.layer.cornerRadius = 16
        addImageViewOutlet.layer.cornerRadius = 20
        
    }
}
