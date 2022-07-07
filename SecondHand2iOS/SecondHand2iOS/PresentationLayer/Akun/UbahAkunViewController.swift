//
//  UbahAkunViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class UbahAkunViewController: UIViewController {
    
    let callAuthAPI = SHAuthAPI()
    
    @IBOutlet weak var ubahImageViewOutlet: UIImageView!
    @IBOutlet weak var ubahNamaOutlet: UITextField!
    @IBOutlet weak var ubahKotaOutlet: UITextField!
    @IBOutlet weak var ubahAlamatOutlet: UITextField!
    @IBOutlet weak var ubahNomorOutlet: UITextField!
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    var access_token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        buttonSimpanOutlet.layer.cornerRadius = 16
        ubahImageViewOutlet.layer.cornerRadius = 20
        
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print(UserDefaults.standard.string(forKey: "access_token")!)
        }
        
        callAuthAPI.getUserDataSecondHand(access_token: access_token) { result in
            switch result {
            case let .success(data):
                self.ubahNamaOutlet.text = data.full_name
                self.ubahImageViewOutlet.loadImage(resource: data.image_url)
                self.ubahKotaOutlet.text = data.city
                self.ubahAlamatOutlet.text = data.address
                self.ubahNomorOutlet.text = data.phone_number
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
    }
}

