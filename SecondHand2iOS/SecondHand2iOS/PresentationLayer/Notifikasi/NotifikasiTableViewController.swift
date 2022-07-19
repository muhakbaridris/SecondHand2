//
//  NotifikasiTableViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class NotifikasiTableViewController: UITableViewController {
    
    var access_token = AccessTokenCache.get()
    let callNotifAPI = SHNotificationAPI()
    var notifArray: [NotificationResponseModel] = []
    
    @IBOutlet var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        callNotifAPI.getNotificationAll(access_token: access_token) { result in
            switch result {
            case let .success(data):
                for i in data {
                    self.notifArray.append(i)
                }
                print(self.notifArray.count)
                self.tableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        notificationTableView.register(UINib.init(nibName:"NotificationTableViewCell" , bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notifArray.count == 0 {
            return 1
        } else {
            return notifArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "NotificationTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? NotificationTableViewCell else {
            return reusableCell
        }
        
        if notifArray.count == 0 {
            cell.notificationnName.text = "Tidak ada data"
            cell.notificationType.text = ""
            cell.notificationTawar.text = ""
            cell.notificationDate.text = ""
            cell.notificationPrice.text = ""
            return cell
        } else {
            let dataproduk = notifArray[indexPath.row]
            switch dataproduk.status {
            case "bid":
                cell.notificationType.text = "Penawaran produk"
            case "create":
                cell.notificationType.text = "Berhasil diterbitkan"
            case "terima":
                cell.notificationType.text = "Berhasil diterima"
            case "declined":
                cell.notificationType.text = "Penawaran ditolak"
            default:
                break
            }
            
            cell.notificationnName.text = dataproduk.product_name
            cell.notificationPrice.text = "Rp \((dataproduk.Product.base_price).formattedWithSeparator)"
            switch dataproduk.bid_price {
            case nil:
                cell.notificationTawar.text = .none
            default:
                cell.notificationTawar.text =  "Ditawar Rp \((dataproduk.bid_price!).formattedWithSeparator)"
            }
            cell.notificationImage.setImageFrom(dataproduk.image_url!)
            cell.notificationDate.text = dateFormatter(date: dataproduk.updatedAt)
            return cell
        }
    }
    
    func dateFormatter(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, HH:mm"
        return dateFormatterPrint.string(from: dateFormatterGet.date(from: date)!)
    }
}

struct ProductDitawar {
    let namadata: String
    let hargadata: String
    let testdata: String
    let hargatawar: String
    let tanggal: String
}
