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
    var produkData: [SHAllProductResponseModel] = []
    
    let userData = UserProfileCache.get()
    let callProductAPI = SHSellerProductAPI()
    
    @IBOutlet var judul: UILabel!
    @IBOutlet var akunImg: UIImageView!
    @IBOutlet var namaAkun: UILabel!
    @IBOutlet var btnAkun: UIButton!
    @IBOutlet var kotaAkun: UILabel!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namaAkun.text = userData!.full_name
        kotaAkun.text = userData!.city
        akunImg.loadImage(resource: userData!.image_url)
        
        daftarJualTableView.register(UINib.init(nibName:"DaftarJualTableViewCell" , bundle: nil), forCellReuseIdentifier: "DaftarJualTableViewCell")
        daftarJualTableView.delegate = self
        daftarJualTableView.dataSource = self
        
        daftarJualCollectionView.delegate = self
        daftarJualCollectionView.dataSource = self
        btnAkun.layer.cornerRadius = 12
        btnAkun.layer.borderWidth = 1
        btnAkun.layer.borderColor = UIColor.purple.cgColor
        akun.layer.borderWidth = 1
        akun.layer.borderColor = UIColor.gray.cgColor
        buttonDesign()
        
        callProductAPI.getAllSellerProduct(access_token: AccessTokenCache.get()) { [weak self] (result) in
            switch result {
            case let .success(data):
                self!.produkData = data
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    func buttonDesign(){
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
    
    @IBAction func btn1(_ sender: Any) {
        testdata = ["Penawaran Produk","Penawaran Produk","Penawaran Produk"]
        namadata = ["Jam Tangan Casio","Jam Tangan Casio","Jam Tangan Casio"]
        hargadata = ["Rp 250.000","Rp 250.000","Rp 250.000"]
        hargatawar = ["Rp 200.000","Rp 200.000","Rp 200.000"]
        tanggal = ["20 Apr, 14:04","20 Apr, 14:04","20 Apr, 14:04"]
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
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

    @IBAction func btn2(_ sender: Any) {
        testdata = ["Penawaran Produk","Penawaran Produk"]
        namadata = ["Jam Tangan Casio","Jam Tangan Casio"]
        hargadata = ["Rp 250.000","Rp 250.000"]
        hargatawar = ["Rp 200.000","Rp 200.000"]
        tanggal = ["20 Apr, 14:04","20 Apr, 14:04"]
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
        btn1.titleLabel?.font = .systemFont(ofSize: 10)
        btn2.titleLabel?.font = .systemFont(ofSize: 10)
        btn3.titleLabel?.font = .systemFont(ofSize: 10)
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
        if indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 2
        } else {
            let viewController = UIStoryboard(name: "BuyerViewController", bundle: nil).instantiateViewController(withIdentifier: "BuyerViewController") as? BuyerViewController
            let produk = produkData[indexPath.row - 1]
            viewController?.idBarang = produk.id!
            viewController?.namaBarang = produk.name!
            viewController?.kategoriBarang = produk.Categories!.first?.name ?? ""
            viewController?.hargaBarang = produk.base_price!
            viewController?.deskripsiBarang = produk.description!
            viewController?.urlGambarBarang = produk.image_url!
            viewController?.arrBannerImage = [produk.image_url!]
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        let cell = daftarJualCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor =  UIColor.gray.cgColor
        cell?.layer.borderWidth = 1
        cell?.isSelected = true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = daftarJualCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 1
        cell?.isSelected = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produkData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "TambahProduk", for: indexPath)
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            return cell
        } else {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "DaftarJualCollectionViewCell", for: indexPath) as! DaftarJualCollectionViewCell
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            let products = produkData[indexPath.row - 1]
            cell.image.loadImage(resource: products.image_url)
            cell.nama.text = products.name
            cell.tipe.text = products.Categories!.first?.name ?? ""
            cell.harga.text = "Rp \(products.base_price!.formattedWithSeparator)"
            return cell
        }
    }
}
