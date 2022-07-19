//
//  OverlayBuyerView.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 27/06/22.
//

import UIKit

final class OverlayBuyerView: UIViewController {
    
    @IBOutlet weak var topSliderOutlet: UIView!
    @IBOutlet weak var borderViewProduct: UIView!
    @IBOutlet weak var gambarBarangImageOutlet: UIImageView!
    @IBOutlet weak var namaBarangLabelOutlet: UILabel!
    @IBOutlet weak var hargaBarangLabelOutlet: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var priceView: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    var callBuyerAPI = SHBuyerOrderAPI()
    var access_token: String = ""
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var idBarang: Int = 0
    var barangImageURL: String = ""
    var namaBarang: String = ""
    var hargaBarang: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayBuyerDesign()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print("\n\(UserDefaults.standard.string(forKey: "access_token")!)\n")
        }
        
        gambarBarangImageOutlet.setImageFrom(barangImageURL)
        namaBarangLabelOutlet.text = namaBarang
        hargaBarangLabelOutlet.text = "Rp \(hargaBarang.formattedWithSeparator)"
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.borderViewProduct.frame.origin
        }
    }
    
    @IBAction func buttonKirimTapIn(_ sender: Any) {
        if priceView.text?.isEmpty == true || priceView.text == "0" {
            CustomToast.show(message: "Masukan harga tawar.",
                             bgColor: .systemRed,
                             textColor: .white,
                             labelFont: .systemFont(ofSize: 17),
                             showIn: .bottom,
                             controller: self)
        } else {
            let rawPrice = priceView.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let bid = SHPostBuyerOrderModel(
                product_id: idBarang,
                bid_price: Int(rawPrice)!)
            callBuyerAPI.postBuyerOrder(access_token: access_token, bid: bid) { result in
                switch result {
                case let .success(data):
                    print(data)
                    CustomToast.show(message: "Anda berhasil menawar, tunggu konfirmasi dari penjual.",
                                     bgColor: .systemGreen,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true)
                    }
                case let .failure(err):
                    print(err.localizedDescription)
                    CustomToast.show(message: "Anda gagal menawar, barang sudah memenuhi batas order.",
                                     bgColor: .systemRed,
                                     textColor: .white,
                                     labelFont: .systemFont(ofSize: 17),
                                     showIn: .bottom,
                                     controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: borderViewProduct)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        borderViewProduct.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: borderViewProduct)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.borderViewProduct.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func overlayBuyerDesign(){
        btnSend.clipsToBounds = true
        btnSend.layer.cornerRadius = 5
        topSliderOutlet.clipsToBounds = true
        topSliderOutlet.layer.cornerRadius = 5
        borderView.clipsToBounds = true
        borderView.layer.backgroundColor = UIColor.white.cgColor
        borderView.layer.cornerRadius = 5
        borderView.layer.masksToBounds = false
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOffset = CGSize.zero
        borderView.layer.shadowRadius = 4
        borderView.layer.shadowOpacity = 0.15
        priceView.layer.cornerRadius = 5
        borderViewProduct.backgroundColor = UIColor.white
        borderViewProduct.clipsToBounds = true
        borderViewProduct.layer.borderColor = UIColor.gray.cgColor
        borderViewProduct.layer.cornerRadius = 16
        borderViewProduct.layer.masksToBounds = false
        borderViewProduct.layer.shadowColor = UIColor.black.cgColor
        borderViewProduct.layer.shadowOffset = CGSize.zero
        borderViewProduct.layer.shadowOpacity = 0.15
        borderViewProduct.layer.shadowRadius = 4
    }
}
