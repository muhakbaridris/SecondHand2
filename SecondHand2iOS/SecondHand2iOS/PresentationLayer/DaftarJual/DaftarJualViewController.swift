//
//  DaftarJualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit



final class DaftarJualViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var akun: UIView!
    @IBOutlet var daftarJualTableView: UITableView!
    @IBOutlet var daftarJualCollectionView: UICollectionView!
    
    var testdata = [String]()
    var namadata = [String]()
    var hargadata = [String]()
    var hargatawar = [String]()
    var tanggal = [String]()
    var cvnama = [String]()
    var cvharga = [String]()
    var cvtipe = [String]()
    
    @IBOutlet var judul: UILabel!
    @IBOutlet var akunImg: UIImageView!
    @IBOutlet var namaAkun: UILabel!
    @IBOutlet var btnAkun: UIButton!
    @IBOutlet var kotaAkun: UILabel!
    
    
    @IBOutlet var btn1: UIButton!
    @IBAction func btn1(_ sender: Any) {
        
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
        testdata = ["Penawaran Produk","Penawaran Produk","Penawaran Produk"]
        namadata = ["Jam Tangan Casio","Jam Tangan Casio","Jam Tangan Casio"]
        hargadata = ["Rp 250.000","Rp 250.000","Rp 250.000"]
        hargatawar = ["Rp 200.000","Rp 200.000","Rp 200.000"]
        tanggal = ["20 Apr, 14:04","20 Apr, 14:04","20 Apr, 14:04"]
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn2.setTitleColor(UIColor.black, for: .normal)
        btn3.setTitleColor(UIColor.black, for: .normal)
        btn2.backgroundColor = UIColor.init(red: 224/255.0, green: 213/255.0, blue: 238/255.0, alpha: 1.0)
        btn1.backgroundColor = UIColor.init(red: 104/255.0, green: 43/255.0, blue: 174/255.0, alpha: 1.0)
        btn3.backgroundColor = UIColor.init(red: 224/255.0, green: 213/255.0, blue: 238/255.0, alpha: 1.0)
        btn1.layer.cornerRadius = 10
        btn1.clipsToBounds = true
        btn2.layer.cornerRadius = 10
        btn2.clipsToBounds = true
        btn3.layer.cornerRadius = 10
        btn3.clipsToBounds = true
    }

 
    @IBOutlet var btn2: UIButton!
    @IBAction func btn2(_ sender: Any) {
        
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
        testdata = ["Penawaran Produk","Penawaran Produk"]
        namadata = ["Jam Tangan Casio","Jam Tangan Casio"]
        hargadata = ["Rp 250.000","Rp 250.000"]
        hargatawar = ["Rp 200.000","Rp 200.000"]
        tanggal = ["20 Apr, 14:04","20 Apr, 14:04"]
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
        btn2.setTitleColor(UIColor.white, for: .normal)
        btn1.setTitleColor(UIColor.black, for: .normal)
        btn3.setTitleColor(UIColor.black, for: .normal)
        btn1.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn2.backgroundColor = UIColor.init(red: 104/255, green: 43/255, blue: 174/255, alpha: 1.0)
        btn3.backgroundColor = UIColor.init(red: 224/255.0, green: 213/255.0, blue: 238/255.0, alpha: 1.0)
        btn1.layer.cornerRadius = 10
        btn1.clipsToBounds = true
        btn2.layer.cornerRadius = 10
        btn2.clipsToBounds = true
        btn3.layer.cornerRadius = 10
        btn3.clipsToBounds = true
        
    }
    
    @IBOutlet var btn3: UIButton!
    @IBAction func btn3(_ sender: Any) {
        cvtipe = ["Aksesoris","Aksesoris"]
        cvnama = ["Jam Tangan Casio","Jam Tangan Casio"]
        cvharga = ["Rp 250.000","Rp 250.000"]
        daftarJualCollectionView.reloadData()
        daftarJualTableView.isHidden = true
        daftarJualCollectionView.isHidden = false
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.setTitleColor(UIColor.white, for: .normal)
        btn2.setTitleColor(UIColor.black, for: .normal)
        btn1.setTitleColor(UIColor.black, for: .normal)
        btn1.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn2.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn3.backgroundColor = UIColor.init(red: 104/255, green: 43/255, blue: 174/255, alpha: 1.0)
        btn2.layer.cornerRadius = 10
        btn2.clipsToBounds = true
        btn1.layer.cornerRadius = 10
        btn1.clipsToBounds = true
        btn3.layer.cornerRadius = 10
        btn3.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        judul.font = UIFont(name: "Poppins-ExtraBold.ttf", size: 40)
       
        
        daftarJualTableView.register(UINib.init(nibName:"DaftarJualTableViewCell" , bundle: nil), forCellReuseIdentifier: "DaftarJualTableViewCell")
        daftarJualTableView.delegate = self
        daftarJualTableView.dataSource = self
        
        daftarJualCollectionView.delegate = self
        daftarJualCollectionView.dataSource = self
        
        namaAkun.text = "Arief"
        kotaAkun.text = "Bekasi"
        btnAkun.layer.cornerRadius = 12
        btnAkun.layer.borderWidth = 1
        btnAkun.layer.borderColor = UIColor.purple.cgColor
        akun.layer.borderWidth = 1
        akun.layer.borderColor = UIColor.gray.cgColor
        
        btn1.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn2.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn3.backgroundColor = UIColor.init(red: 224/255, green: 213/255, blue: 238/255, alpha: 1.0)
        btn2.layer.cornerRadius = 10
        btn2.clipsToBounds = true
        btn1.layer.cornerRadius = 10
        btn1.clipsToBounds = true
        btn3.layer.cornerRadius = 10
        btn3.clipsToBounds = true
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "DaftarJualTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? DaftarJualTableViewCell else {
            return reusableCell
        }
        
        cell.daftarJualType.text = testdata[indexPath.row]
        cell.daftarJualName.text = namadata[indexPath.row]
        cell.daftarJualPrice.text = hargadata[indexPath.row]
        cell.daftarJualTawar.text = hargatawar[indexPath.row]
        cell.daftarJualDate.text = tanggal[indexPath.row]
        
        
        return cell
    }
    

}

extension DaftarJualViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = daftarJualCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 1
        cell?.isSelected = true
    }


    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = daftarJualCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.layer.borderWidth = 1
        cell?.isSelected = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cvnama.count)
        return cvnama.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "TambahProduk", for: indexPath)
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            
            return cell
        } else{
            
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "DaftarJualCollectionViewCell", for: indexPath) as! DaftarJualCollectionViewCell
            
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            
            
            cell.nama.text = cvnama[indexPath.row]
            cell.tipe.text = cvtipe[indexPath.row]
            cell.harga.text = cvharga[indexPath.row]
            
            return cell
        }
        
        

        
    }
}
