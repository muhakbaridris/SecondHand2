//
//  AkunViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class AkunViewController: UIViewController{
    
    @IBOutlet weak var userImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        userImageOutlet.layer.cornerRadius = 20
        
    }
    
    @IBAction func buttonPengaturanTapIn(_ sender: Any) {
        CustomToast.show(
            message: "Fitur ini sedang dikembangkan",
            bgColor: .red,
            textColor: .white,
            labelFont: .systemFont(ofSize: 18),
            showIn: .bottom,
            controller: self
        )
    }
    
    @IBAction func buttonKeluarTapIn(_ sender: Any) {
        
    }
    
    
}
