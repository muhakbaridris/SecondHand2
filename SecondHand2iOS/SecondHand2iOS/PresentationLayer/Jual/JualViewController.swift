//
//  JualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class JualViewController: UIViewController {
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var pushLabel: UILabel!
    @IBOutlet weak var uiPreviewLabel: UILabel!
    @IBOutlet weak var uiNamaProduk: UITextField!
    @IBOutlet weak var uiPushLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        uiPreviewLabel.layer.cornerRadius = 22
        uiPushLabel.layer.cornerRadius = 22
        uiNamaProduk.layer.cornerRadius = 22
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
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "JualViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "showPreview") as? Seller18ViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
