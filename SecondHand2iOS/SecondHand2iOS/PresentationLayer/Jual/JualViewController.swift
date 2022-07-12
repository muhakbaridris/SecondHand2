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
    let kategoriModel = CategoryCache.get()
    let dropDown = DropDown()
    var kategori: [String] = []
    var idCategory: Int = 0
    
    
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
        
        
    }
    
    @objc func tapPreviewFunction(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "JualViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "showPreview") as? PreviewJualViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePicker.image = pickedImage
        }
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
