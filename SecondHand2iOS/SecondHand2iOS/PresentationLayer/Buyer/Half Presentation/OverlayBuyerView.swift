//
//  OverlayBuyerView.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 27/06/22.
//

import UIKit

final class OverlayBuyerView: UIViewController {
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var borderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSend.clipsToBounds = true
        btnSend.layer.cornerRadius = 16
        sliderView.clipsToBounds = true
        sliderView.layer.cornerRadius = 4
        borderView.clipsToBounds = true
        borderView.layer.backgroundColor = UIColor.white.cgColor
        borderView.layer.cornerRadius = 16
        borderView.layer.masksToBounds = false
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOffset = CGSize.zero
        borderView.layer.shadowRadius = 4
        borderView.layer.shadowOpacity = 0.15
    }
}
