//
//  NotificationTableViewCell.swift
//  SecondHand2iOS
//
//  Created by Aiedyl Dava Akbari on 15/06/22.
//

import UIKit

class DaftarJualTableViewCell: UITableViewCell {

    
    @IBOutlet var daftarJualType: UILabel!
    @IBOutlet var daftarJualName: UILabel!
    @IBOutlet var daftarJualPrice: UILabel!
    @IBOutlet var daftarJualTawar: UILabel!
    @IBOutlet var daftarJualDate: UILabel!
    @IBOutlet var daftarJualImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        daftarJualImage.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
