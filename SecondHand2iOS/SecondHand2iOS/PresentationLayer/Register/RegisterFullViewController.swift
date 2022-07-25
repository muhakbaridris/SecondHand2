//
//  RegisterFullViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 29/06/22.
//

import UIKit

final class RegisterFullViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImageViewOutlet: UIImageView!
    @IBOutlet weak var namaTextFieldOutlet: UITextField!
    @IBOutlet weak var kotaTextFieldOutlet: UITextField!
    @IBOutlet weak var alamatTextFieldOutlet: UITextField!
    @IBOutlet weak var nomorTextFieldOutlet: UITextField!
    
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    let callAuthAPI = SHAuthAPI()
    var namaTerdaftar: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lengkapi Info Akun"
        namaTextFieldOutlet.text = namaTerdaftar!
        addImageViewOutlet.image = UIImage(named: "addImage")
        buttonSimpanOutlet.layer.cornerRadius = 16
        addImageViewOutlet.layer.cornerRadius = 20
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        addImageViewOutlet.isUserInteractionEnabled = true
        addImageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
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
            addImageViewOutlet.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonSimpanTapIn(_ sender: Any) {
        if namaTextFieldOutlet.text?.isEmpty == true ||
            kotaTextFieldOutlet.text?.isEmpty == true ||
            alamatTextFieldOutlet.text?.isEmpty == true ||
            nomorTextFieldOutlet.text?.isEmpty == true ||
            addImageViewOutlet.image == UIImage(named: "addImage")
        {
            CustomToast.show(message: "Harap lengkapi info akun.",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            let changeAccount = ChangeAccountModel(
                full_name: namaTextFieldOutlet.text!,
                phone_number: nomorTextFieldOutlet.text!,
                address: alamatTextFieldOutlet.text!,
                image: "\(String(describing: addImageViewOutlet.image))",
                city: kotaTextFieldOutlet.text!)
            
            callAuthAPI.changeAccountSecondHand(
                changeAccountData: changeAccount,
                media: addImageViewOutlet.image!,
                access_token: AccessTokenCache.get()
            ) { result in
                switch result {
                case let .success(data):
                    print(data)
                    UserProfileCache.save(data)
                    CustomToast.show(
                        message: "Berhasil Perbaharui Data",
                        bgColor: .systemGreen,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let viewController = UIStoryboard(name: "TabBarMainViewController",
                                                          bundle: nil)
                            .instantiateViewController(withIdentifier: "TabBarMainViewController")
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true)
                    }
                case let .failure(err):
                    print(err.localizedDescription)
                    CustomToast.show(
                        message: "Silahkan coba beberapa saat lagi.",
                        bgColor: .systemGreen,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                }
            }
        }
    }
}
