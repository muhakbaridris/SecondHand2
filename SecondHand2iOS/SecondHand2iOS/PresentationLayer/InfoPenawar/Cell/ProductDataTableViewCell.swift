//
//  ProductDataTableViewCell.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 22/06/22.
//

import UIKit

class ProductDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productStatus: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTawarHarga: UILabel!
    @IBOutlet weak var dateStatus: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnHubungi: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        var imageWa = UIImage(named: "fi_whatsapp")?.withTintColor(.white)
        self.btnStatus?.layer.borderWidth = 1
        self.btnStatus?.layer.borderColor = UIColor(named: "Purple4")?.cgColor
        self.btnStatus?.layer.cornerRadius = 16
        self.btnHubungi?.layer.cornerRadius = 16
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
