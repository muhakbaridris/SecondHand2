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
    let userData = UserProfileCache.get()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        buttonSimpanOutlet.layer.cornerRadius = 16
        ubahImageViewOutlet.layer.cornerRadius = 20
        ubahNamaOutlet.text = userData!.full_name
        ubahImageViewOutlet.loadImage(resource: userData!.image_url)
        ubahKotaOutlet.text = userData!.city
        ubahAlamatOutlet.text = userData!.address
        ubahNomorOutlet.text = userData!.phone_number
    }
    
    @IBAction func buttonUbahPasswordTapIn(_ sender: Any) {let viewController = UIStoryboard(name: "UbahPasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "UbahPasswordViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

