//
//  UbahAkunViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class UbahAkunViewController: UIViewController {
    
    @IBOutlet weak var ubahImageViewOutlet: UIImageView!
    @IBOutlet weak var ubahNamaOutlet: UITextField!
    @IBOutlet weak var ubahKotaOutlet: UITextField!
    @IBOutlet weak var ubahAlamatOutlet: UITextField!
    @IBOutlet weak var ubahNomorOutlet: UITextField!
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        buttonSimpanOutlet.layer.cornerRadius = 16
        ubahImageViewOutlet.layer.cornerRadius = 20
        
    }
}

