//
//  OverlayPenawarView.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 27/06/22.
//

import UIKit

final class OverlayPenawarView: UIViewController {
    
    @IBOutlet weak var topSliderOutlet: UIView!
    @IBOutlet weak var berhasil: UIButton!
    @IBOutlet weak var batalkan: UIButton!
    @IBOutlet weak var kirim: UIButton!
    let callAPI = SHSellerProductAPI()
    var flag = false
    var flag1 = false
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var productID: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topSliderOutlet.clipsToBounds = true
        topSliderOutlet.layer.cornerRadius = 5
        kirim.layer.cornerRadius = 16
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @IBAction func berhasil(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            batalkan.isSelected = false
            kirim.isSelected = false
        } else {
            sender.isSelected = true
            batalkan.isSelected = false
            kirim.isSelected = true
            if(kirim.isSelected){
                kirim.backgroundColor =  UIColor(red: 104.0/255.0, green: 43.0/255.0, blue: 174.0/255.0, alpha: 1.0)
            }
        }
    }
    
    @IBAction func batalkan(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            berhasil.isSelected = false
            kirim.isSelected = false
        } else {
            sender.isSelected = true
            berhasil.isSelected = false
            kirim.isSelected = true
            if(kirim.isSelected){
                kirim.backgroundColor =  UIColor(red: 104.0/255.0, green: 43.0/255.0, blue: 174.0/255.0, alpha: 1.0)
            }
        }
    }
    
    @IBAction func kirim(_ sender: Any) {
        if berhasil.isSelected == true {
            callAPI.patchSellerProductID(
                access_token: AccessTokenCache.get(),
                productID: productID!,
                status: "sold") { response in
                    switch response {
                    case let .success(data):
                        print("Barang \(data.name!) berhasil terjual.")
                        CustomToast.show(
                            message: "Selamat! produkmu berhasil terjual.",
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
                        CustomToast.show(
                            message: "Terjadi galat, silahkan coba lagi.",
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
        } else if batalkan.isSelected == true {
            callAPI.patchSellerProductID(
                access_token: AccessTokenCache.get(),
                productID: productID!,
                status: "available") { response in
                    switch response {
                    case let .success(data):
                        print("Barang \(data.name!) batal terjual.")
                        CustomToast.show(
                            message: "Pembatalan transaksi berhasil.",
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
                        CustomToast.show(
                            message: "Terjadi galat, silahkan coba lagi.",
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
        } else {
            CustomToast.show(
                message: "Pilih perubahaan status produkmu.",
                bgColor: .systemRed,
                textColor: .white,
                labelFont: .systemFont(ofSize: 17),
                showIn: .bottom,
                controller: self)
        }
    }
}
