//
//  OverlayBuyerView.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 27/06/22.
//

import UIKit

final class OverlayBuyerView: UIViewController {
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var topSliderOutlet: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var priceView: UITextField!
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    @IBOutlet weak var borderViewProduct: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayBuyerDesign()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        borderViewProduct.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.borderViewProduct.frame.origin
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
                // Set back to original position of the view controller
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
