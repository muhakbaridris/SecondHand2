//
//  OverlayPenawarView.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 27/06/22.
//

import UIKit

final class OverlayPenawarView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topSliderOutlet.clipsToBounds = true
        topSliderOutlet.layer.cornerRadius = 5
        kirim.layer.cornerRadius = 16
        
    }
    
    var flag = false
    var flag1 = false
    
    @IBOutlet weak var topSliderOutlet: UIView!
    @IBOutlet var kirim: UIButton!
    @IBOutlet var berhasil: UIButton!
    @IBOutlet var batalkan: UIButton!
    
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
        
    }
}
