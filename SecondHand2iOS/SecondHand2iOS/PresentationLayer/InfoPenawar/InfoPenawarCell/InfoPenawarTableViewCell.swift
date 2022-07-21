//
//  InfoPenawarCell.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 22/07/22.
//

import UIKit

class InfoPenawarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var barangImageOutlet: UIImageView!
    @IBOutlet weak var labelStatusProdukOutlet: UILabel!
    @IBOutlet weak var labelNamaProdukOutlet: UILabel!
    @IBOutlet weak var labelHargaProdukOutlet: UILabel!
    @IBOutlet weak var labelHargaTawarOutlet: UILabel!
    @IBOutlet weak var tanggalTransaksiProdukOutlet: UILabel!
    
    @IBOutlet weak var buttonStatusOutlet: UIButton!
    @IBOutlet weak var buttonHubungiOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonStatusOutlet.layer.cornerRadius = 16
        buttonStatusOutlet.layer.backgroundColor = UIColor.white.cgColor
        buttonStatusOutlet.layer.borderWidth = 1
        buttonStatusOutlet.layer.borderColor = UIColor(named: "Purple4")!.cgColor
        
        buttonHubungiOutlet.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
