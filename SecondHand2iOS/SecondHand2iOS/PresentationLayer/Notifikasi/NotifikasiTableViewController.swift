//
//  NotifikasiTableViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class NotifikasiTableViewController: UITableViewController {
    
    var products = [ProductDitawar]()
    
    @IBOutlet var notificationTableView: UITableView!
//    let testdata = ["Penawaran Produk","Penawaran Produk","Penawaran Produk"]
//    let namadata = ["Jam Tangan Casio","Jam Tangan Casio","Jam Tangan Casio"]
//    let hargadata = ["Rp 250.000","Rp 250.000","Rp 250.000"]
//    let hargatawar = ["Ditawar Rp 200.000","Ditawar Rp 200.000","Ditawar Rp 200.000"]
//    let tanggal = ["20 Apr, 14:04","20 Apr, 14:04","20 Apr, 14:04"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        notificationTableView.register(UINib.init(nibName:"NotificationTableViewCell" , bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        configureProducts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "NotificationTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? NotificationTableViewCell else {
            return reusableCell
        }
        let dataproduk = products[indexPath.row]
        cell.notificationType.text = dataproduk.testdata
        cell.notificationnName.text = dataproduk.namadata
        cell.notificationPrice.text = dataproduk.hargadata
        cell.notificationTawar.text = dataproduk.hargatawar
        cell.notificationDate.text = dataproduk.tanggal
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "InfoPenawarViewController", bundle: nil).instantiateViewController(withIdentifier: "penawar") as! InfoPenawarViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func configureProducts() {
        products.append(ProductDitawar(namadata: "Jam Tangan Casio",
                          hargadata: "Rp 250.000",
                          testdata: "Penawaran Produk",
                          hargatawar: "Ditawar Rp 200.000",
                          tanggal: "20 Apr, 14:04"))
        products.append(ProductDitawar(namadata: "Jam Tangan Casio",
                          hargadata: "Rp 250.000",
                          testdata: "Penawaran Produk",
                          hargatawar: "Ditawar Rp 200.000",
                          tanggal: "20 Apr, 14:04"))
        products.append(ProductDitawar(namadata: "Jam Tangan Casio",
                          hargadata: "Rp 250.000",
                          testdata: "Penawaran Produk",
                          hargatawar: "Ditawar Rp 200.000",
                          tanggal: "20 Apr, 14:04"))
    }
}

struct ProductDitawar {
    let namadata: String
    let hargadata: String
    let testdata: String
    let hargatawar: String
    let tanggal: String
}
