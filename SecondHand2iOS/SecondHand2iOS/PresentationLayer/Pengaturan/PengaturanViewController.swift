//
//  PengaturanViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 28/06/22.
//

import LocalAuthentication
import UIKit

final class PengaturanViewController: UIViewController {
    
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        switchButton.isOn =  UserDefaults.standard.bool(forKey: "switchState")
    }
    
    @IBAction func saveSwitchPressed(_ sender: UISwitch) {
            UserDefaults.standard.set(sender.isOn, forKey: "switchState")
        }
}
