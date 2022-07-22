//
//  JualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit
import DropDown

final class JualViewController: UIViewController {
    
    @IBOutlet weak var namaProdukOutlet: UITextField!
    @IBOutlet weak var hargaProdukOutlet: UITextField!
    @IBOutlet weak var kategoriProdukOutlet: UITextField!
    @IBOutlet weak var deskripsiProdukOutlet: UITextField!
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var buttonPreviewOutlet: UIButton!
    @IBOutlet weak var buttonTerbitkanOutlet: UIButton!
    
    let postProductAPI = SHSellerProductAPI()
    let kategoriModel = CategoryCache.get()
    let access_token = AccessTokenCache.get()
    let dropDown = DropDown()
    var kategori: [String] = []
    var idCategory: Int = 0
    var photoName: String = ""
    var rawPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jualViewControllerDesign()
        self.hideKeyboardWhenTappedAround()
        for i in CategoryCache.get()! {
            kategori.append(i.name!)
        }
        dropDownKategori()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagePicker.isUserInteractionEnabled = true
        imagePicker.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dropDownKategori(){
        dropDown.anchorView = kategoriProdukOutlet
        dropDown.dataSource = kategori
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.kategoriProdukOutlet.text = kategori[index]
            for index in CategoryCache.get()! {
                if index.name == kategoriProdukOutlet.text {
                    print("Nama kategori \(String(describing: index.name)), id nya \(String(describing: index.id))")
                    idCategory = index.id!
                }
            }
          }
    }
    
    func jualViewControllerDesign(){
        buttonPreviewOutlet.layer.cornerRadius = 16
        buttonPreviewOutlet.layer.backgroundColor = UIColor.white.cgColor
        buttonPreviewOutlet.layer.borderWidth = 1
        buttonPreviewOutlet.layer.borderColor = UIColor(named: "Purple4")!.cgColor
        
        buttonTerbitkanOutlet.layer.cornerRadius = 16
    }
    
    @IBAction func kategoriTextFieldTapIn(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func previewButtonTapIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "JualViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "showPreview") as? PreviewJualViewController else {
            return
        }
        if namaProdukOutlet.text?.isEmpty == true ||
            hargaProdukOutlet.text == "0" ||
            kategoriProdukOutlet.text?.isEmpty == true ||
            deskripsiProdukOutlet.text?.isEmpty == true ||
            imagePicker.image == nil
        {
            CustomToast.show(message: "Harap lengkapi data produk.",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            viewController.produkName = namaProdukOutlet.text!
            viewController.produkPrice = hargaProdukOutlet.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            viewController.produkKategori = kategoriProdukOutlet.text!
            viewController.idKategori = idCategory
            viewController.deskripsiProduk = deskripsiProdukOutlet.text!
            viewController.imageData = imagePicker.image ?? nil
            viewController.imageName = photoName
            viewController.completion = { [weak self] value in
                DispatchQueue.main.async {
                    if value == true {
                        self?.namaProdukOutlet.text = nil
                        self?.hargaProdukOutlet.text = nil
                        self?.kategoriProdukOutlet.text = nil
                        self?.deskripsiProdukOutlet.text = nil
                        self?.imagePicker.image = UIImage(named: "addImage")
                    }
                }
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func terbitkanButtonTapIn(_ sender: Any) {
        print(idCategory)
        if namaProdukOutlet.text?.isEmpty == true ||
            hargaProdukOutlet.text == "0" ||
            kategoriProdukOutlet.text?.isEmpty == true ||
            deskripsiProdukOutlet.text?.isEmpty == true ||
            imagePicker.image == nil
        {
            CustomToast.show(message: "Harap lengkapi data produk.",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            rawPrice = hargaProdukOutlet.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            postProductAPI.postSellerProduct(
                access_token: access_token,
                name: namaProdukOutlet.text!,
                description: deskripsiProdukOutlet.text!,
                base_price: Int(rawPrice)!,
                categoryID: idCategory,
                location: UserProfileCache.get().city ?? "",
                imageName: photoName,
                image: imagePicker.image!)
            { [weak self] response in
                switch response {
                case .success(let data):
                    print("Upload \(String(describing: data.name)) Success")
                    self?.namaProdukOutlet.text = nil
                    self?.hargaProdukOutlet.text = nil
                    self?.kategoriProdukOutlet.text = nil
                    self?.deskripsiProdukOutlet.text = nil
                    self?.imagePicker.image = UIImage(named: "addImage")
                    CustomToast.show(message: "Berhasil posting produk.",
                                     bgColor: .systemGreen,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self!)
                case .failure(let err):
                    print(err.localizedDescription)
                    CustomToast.show(message: "Ada kesalahan pada sistem, silahkan coba lagi beberapa saat lagi.",
                                     bgColor: .systemRed,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self!)
                }
            }
        }
    }

}

extension JualViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let imagePickers = UIImagePickerController()
        imagePickers.delegate = self
        imagePickers.allowsEditing = false
        imagePickers.sourceType = .photoLibrary
        present(imagePickers, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePicker.image = pickedImage
        }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        photoName = fileUrl.lastPathComponent
        
        dismiss(animated: true, completion: nil)
    }
}
