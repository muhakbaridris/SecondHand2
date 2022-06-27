//
//  InfoPenawarViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 21/06/22.
//

import UIKit

final class InfoPenawarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var products = [ProductDitawar]()
    
    @IBOutlet weak var cardBgView: UIView!
    @IBOutlet weak var namaPembeli: UILabel!
    @IBOutlet weak var kotaPembeli: UILabel!
    @IBOutlet weak var justLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShadow(view: cardBgView)
        namaPembeli?.text = "Nama Pembeli"
        kotaPembeli?.text = "Kota"
        justLabel?.text = "Daftar Produkmu yang Ditawar"
        tableView.register(UINib.init(nibName:"ProductDataTableViewCell" , bundle: nil), forCellReuseIdentifier: "ProductDataTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        configureProducts()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductDataTableViewCell", for: indexPath)
        guard let cell = reusableCell as? ProductDataTableViewCell else {
            return reusableCell
        }
        
        let dataproduk = products[indexPath.row]
        cell.productStatus.text = dataproduk.testdata
        cell.productName.text = dataproduk.namadata
        cell.productPrice.text = dataproduk.hargadata
        cell.productTawarHarga.text = dataproduk.hargatawar
        cell.dateStatus.text = dataproduk.tanggal
        cell.btnStatus.tag = indexPath.row
        
        return cell
    }
    
    private func configureShadow(view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 4.0
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

