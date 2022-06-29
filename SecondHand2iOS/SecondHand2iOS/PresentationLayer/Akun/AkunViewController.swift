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
        print("tap")
        let viewController = UIStoryboard(name: "PengaturanViewController", bundle: nil).instantiateViewController(withIdentifier: "PengaturanViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func buttonKeluarTapIn(_ sender: Any) {
        print("tap")
    }
    
    
}
