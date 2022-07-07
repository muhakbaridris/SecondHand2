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
    @IBOutlet weak var pilihKotaTextFieldOutlet: UITextField!
    @IBOutlet weak var alamatTextFieldOutlet: UITextField!
    @IBOutlet weak var nomorTextFieldOutlet: UITextField!
    
    @IBOutlet weak var buttonSimpanOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
