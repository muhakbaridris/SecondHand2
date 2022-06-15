//
//  NotifikasiTableViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class NotifikasiTableViewController: UITableViewController {
    
    @IBOutlet var notificationTableView: UITableView!
    let testdata = ["Penawaran Produk","Penawaran Produk","Penawaran Produk"]
    let namadata = ["Jam Tangan Casio","Jam Tangan Casio","Jam Tangan Casio"]
    let hargadata = ["Rp 250.000","Rp 250.000","Rp 250.000"]
    let hargatawar = ["Rp 200.000","Rp 200.000","Rp 200.000"]
    let tanggal = ["20 Apr, 14:04","20 Apr, 14:04","20 Apr, 14:04"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTableView.register(UINib.init(nibName:"NotificationTableViewCell" , bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testdata.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "NotificationTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? NotificationTableViewCell else {
            return reusableCell
        }
        
        cell.notificationType.text = testdata[indexPath.row]
        cell.notificationnName.text = namadata[indexPath.row]
        cell.notificationPrice.text = hargadata[indexPath.row]
        cell.notificationTawar.text = hargatawar[indexPath.row]
        cell.notificationDate.text = tanggal[indexPath.row]
        
        return cell
    }
    
    
}
