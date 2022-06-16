//
//  NotificationTableViewCell.swift
//  SecondHand2iOS
//
//  Created by Aiedyl Dava Akbari on 15/06/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet var notificationType: UILabel!
    @IBOutlet var notificationnName: UILabel!
    @IBOutlet var notificationPrice: UILabel!
    @IBOutlet var notificationTawar: UILabel!
    @IBOutlet var notificationDate: UILabel!
    @IBOutlet var notificationImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
