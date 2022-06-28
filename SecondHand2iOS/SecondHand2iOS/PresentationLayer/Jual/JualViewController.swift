//
//  JualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit
import DropDown

final class JualViewController: UIViewController {
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var pushLabel: UILabel!
    @IBOutlet weak var uiPreviewLabel: UILabel!
    @IBOutlet weak var namaProdukOutlet: UITextField!
    @IBOutlet weak var hargaProdukOutlet: UITextField!
    @IBOutlet weak var kategoriProdukOutlet: UITextField!
    @IBOutlet weak var deskripsiProdukOutlet: UITextField!
    @IBOutlet weak var uiPushLabel: UILabel!
    let kategori: [String] = ["Pilih Kategori", "Elektronik", "Olahraga",
                              "Mainan Anak", "Pakaian", "Alat Tulis", "Lain-lain"]
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jualViewControllerDesign()
        self.hideKeyboardWhenTappedAround()
        dropDownKategori()
    }
    
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "JualViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "showPreview") as? PreviewJualViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dropDownKategori(){
        dropDown.anchorView = kategoriProdukOutlet
        dropDown.dataSource = kategori
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0 {
                self.kategoriProdukOutlet.text = .none
            } else {
                self.kategoriProdukOutlet.text = kategori[index]
            }
          }
    }
    
    @IBAction func kategoriTextFieldTapIn(_ sender: Any) {
        dropDown.show()
    }
    
    func jualViewControllerDesign(){
        self.view.backgroundColor = UIColor.white
        uiPreviewLabel.layer.cornerRadius = 22
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(JualViewController.tapFunction))
        previewLabel.isUserInteractionEnabled = true
        previewLabel.addGestureRecognizer(tap)
    }
}
