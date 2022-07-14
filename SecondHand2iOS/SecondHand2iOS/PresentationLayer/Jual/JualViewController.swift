//
//  JualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit
import DropDown

final class JualViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var pushLabel: UILabel!
    @IBOutlet weak var uiPreviewLabel: UILabel!
    @IBOutlet weak var namaProdukOutlet: UITextField!
    @IBOutlet weak var hargaProdukOutlet: UITextField!
    @IBOutlet weak var kategoriProdukOutlet: UITextField!
    @IBOutlet weak var deskripsiProdukOutlet: UITextField!
    @IBOutlet weak var uiPushLabel: UILabel!
    @IBOutlet weak var imagePicker: UIImageView!
    
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
        previewLabelTapIn()
        terbitkanLabelTapIn()
        self.hideKeyboardWhenTappedAround()
        for i in kategoriModel! {
            kategori.append(i.name)
        }
        dropDownKategori()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagePicker.isUserInteractionEnabled = true
        imagePicker.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let imagePickers = UIImagePickerController()
        imagePickers.delegate = self
        imagePickers.allowsEditing = false
        imagePickers.sourceType = .photoLibrary
        present(imagePickers, animated: true)
        
    }
    
    @objc func tapTerbitkanFunction(sender: UITapGestureRecognizer) {
        for index in kategoriModel! {
            if index.name == kategoriProdukOutlet.text {
                print("Nama kategori \(index.name), id nya \(index.id)")
                idCategory = index.id
            }
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
            rawPrice = hargaProdukOutlet.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            postProductAPI.postSellerProduct(
                access_token: access_token,
                name: namaProdukOutlet.text!,
                description: deskripsiProdukOutlet.text!,
                base_price: Int(rawPrice)!,
                categoryID: idCategory,
                location: UserProfileCache.get().city,
                imageName: photoName,
                image: imagePicker.image!)
            { response in
                switch response {
                case .success(let data):
                    print("Upload \(data.name) Success")
                    self.namaProdukOutlet.text = nil
                    self.hargaProdukOutlet.text = nil
                    self.kategoriProdukOutlet.text = nil
                    self.deskripsiProdukOutlet.text = nil
                    self.imagePicker.image = nil
                    CustomToast.show(message: "Berhasil posting produk.",
                                     bgColor: .systemGreen,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                case .failure(let err):
                    print(err.localizedDescription)
                    CustomToast.show(message: "Ada kesalahan pada sistem, silahkan coba lagi beberapa saat lagi.",
                                     bgColor: .systemRed,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                }
            }
        }
    }
    
    @objc func tapPreviewFunction(sender: UITapGestureRecognizer) {
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
            viewController.deskripsiProduk = deskripsiProdukOutlet.text!
            viewController.imageData = imagePicker.image ?? nil
            viewController.imageName = photoName
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePicker.image = pickedImage
        }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        photoName = fileUrl.lastPathComponent
        
        dismiss(animated: true, completion: nil)
    }
    
    func dropDownKategori(){
        dropDown.anchorView = kategoriProdukOutlet
        dropDown.dataSource = kategori
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.kategoriProdukOutlet.text = kategori[index]
          }
    }
    
    @IBAction func kategoriTextFieldTapIn(_ sender: Any) {
        dropDown.show()
    }
    
    func jualViewControllerDesign(){
        self.view.backgroundColor = UIColor.white
        uiPushLabel.layer.cornerRadius = 22
        namaProdukOutlet.layer.cornerRadius = 22
        previewLabel.layer.borderWidth = 0.2
        previewLabel.layer.cornerRadius = 3
        previewLabel.layer.masksToBounds = true
        previewLabel.layer.borderColor = UIColor(named: "Purple4")?.cgColor
        previewLabel.text = "Preview"
        pushLabel.text = "Terbitkan"
        pushLabel.layer.backgroundColor = UIColor(named: "Purple4")?.cgColor
        pushLabel.textColor = .white
        pushLabel.layer.cornerRadius = 3
    }
    
    func previewLabelTapIn(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(JualViewController.tapPreviewFunction))
        previewLabel.isUserInteractionEnabled = true
        previewLabel.addGestureRecognizer(tap)
    }
    
    func terbitkanLabelTapIn(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(JualViewController.tapTerbitkanFunction))
        pushLabel.isUserInteractionEnabled = true
        pushLabel.addGestureRecognizer(tap)
    }
}
