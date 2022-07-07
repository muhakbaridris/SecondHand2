//
//  AkunViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class AkunViewController: UIViewController{
    
    let callAPI = SHAuthAPI()
    var userDataResponse: [UserDataResponseModel] = []
    @IBOutlet weak var userImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        userImageOutlet.layer.cornerRadius = 20
        
        callAPI.getUserDataSecondHand(access_token: UserDefaults.standard.string(forKey: "access_token")!) { result in
            switch result {
            case let .success(data):
                self.userImageOutlet.loadImage(resource: data.image_url)
                print(data.city)
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
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
