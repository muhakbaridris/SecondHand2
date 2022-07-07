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
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
        CustomToast.show(message: "Anda berhasil logout!",
                         bgColor: .systemGreen,
                         textColor: .white,
                         labelFont: .systemFont(ofSize: 17),
                         showIn: .bottom, controller: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let viewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    
}
