//
//  UbahAkunViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 15/06/22.
//

import UIKit

final class UbahAkunViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let callAuthAPI = SHAuthAPI()
    var access_token: String = ""
    
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
        
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print(access_token)
        }
        
        let userData = UserProfileCache.get()
        ubahNamaOutlet.text = userData!.full_name
        ubahImageViewOutlet.loadImage(resource: userData!.image_url)
        ubahKotaOutlet.text = userData!.city
        ubahAlamatOutlet.text = userData!.address
        ubahNomorOutlet.text = userData!.phone_number
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ubahImageViewOutlet.isUserInteractionEnabled = true
        ubahImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @IBAction func buttonUbahPasswordTapIn(_ sender: Any) {let viewController = UIStoryboard(name: "UbahPasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "UbahPasswordViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            ubahImageViewOutlet.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonSimpanTapIn(_ sender: Any) {
        let changeAccount = ChangeAccountModel(full_name: ubahNamaOutlet.text!, phone_number: ubahNomorOutlet.text!, address: ubahAlamatOutlet.text!, city: ubahKotaOutlet.text!)
        
        callAuthAPI.changeAccountSecondHand(changeAccountData: changeAccount, access_token: access_token) { result in
            switch result {
            case let .success(data):
                print(data)
                CustomToast.show(message: "Berhasil Ubah Data", bgColor: .systemGreen, textColor: .white, labelFont: .systemFont(ofSize: 17), showIn: .bottom, controller: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                    self.navigationController?.popViewController(animated: true)
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
            
        }
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

