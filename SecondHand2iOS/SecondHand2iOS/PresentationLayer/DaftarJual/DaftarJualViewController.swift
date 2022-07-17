//
//  DaftarJualViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

final class DaftarJualViewController: UIViewController{
    
    var testdata = [String]()
    var namadata = [String]()
    var hargadata = [String]()
    var hargatawar = [String]()
    var tanggal = [String]()
    var cvnama = [String]()
    var cvharga = [String]()
    var cvtipe = [String]()
    
    var produkData: [SHAllProductResponseModel] = []
    var diminatiData: [SHSellerOrderResponseModel] = []
    let userData = UserProfileCache.get()
    var access_token: String = AccessTokenCache.get()
    let callProductAPI = SHSellerProductAPI()
    let callOrderAPI = SHSellerOrderAPI()
    
    @IBOutlet var daftarJualTableView: UITableView!
    @IBOutlet var daftarJualCollectionView: UICollectionView!
    
    @IBOutlet var akun: UIView!
    @IBOutlet var akunImg: UIImageView!
    @IBOutlet var namaAkun: UILabel!
    @IBOutlet var btnAkun: UIButton!
    @IBOutlet var kotaAkun: UILabel!
    
    @IBOutlet weak var buttonProdukOutlet: UIButton!
    @IBOutlet weak var imageButtonProdukOutlet: UIImageView!
    @IBOutlet weak var buttonDiminatiOutlet: UIButton!
    @IBOutlet weak var imageButtonDiminatiOutlet: UIImageView!
    @IBOutlet weak var buttonTerjualOutlet: UIButton!
    @IBOutlet weak var imageButtonTerjualOutlet: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        callProductAPI.getAllSellerProduct(access_token: AccessTokenCache.get()) { [weak self] (result) in
            switch result {
            case let .success(data):
                self!.produkData = data
                self!.daftarJualCollectionView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        akunViewDesign()
        stackViewButtonDesign()
        namaAkun.text = userData!.full_name
        kotaAkun.text = userData!.city
        akunImg.loadImage(resource: userData!.image_url)
        
        daftarJualTableView.register(UINib.init(nibName:"DaftarJualTableViewCell" , bundle: nil), forCellReuseIdentifier: "DaftarJualTableViewCell")
        daftarJualTableView.delegate = self
        daftarJualTableView.dataSource = self
        daftarJualTableView.isHidden = true
        
        daftarJualCollectionView.delegate = self
        daftarJualCollectionView.dataSource = self
        daftarJualCollectionView.isHidden = false
    }
    
    func akunViewDesign(){
        akun.backgroundColor = UIColor.white
        akun.clipsToBounds = true
        akun.layer.borderColor = UIColor.gray.cgColor
        akun.layer.cornerRadius = 16
        akun.layer.masksToBounds = false
        akun.layer.shadowColor = UIColor.black.cgColor
        akun.layer.shadowOffset = CGSize.zero
        akun.layer.shadowOpacity = 0.15
        akun.layer.shadowRadius = 4
        
        btnAkun.backgroundColor = UIColor.white
        btnAkun.clipsToBounds = true
        btnAkun.layer.borderColor = UIColor(named: "Purple4")!.cgColor
        btnAkun.layer.borderWidth = 1
        btnAkun.layer.cornerRadius = 8
    }
    
    func stackViewButtonDesign(){
        buttonProdukOutlet.layer.cornerRadius = 8
        imageButtonProdukOutlet.image = UIImage(named: "boxIcon")
        buttonDiminatiOutlet.layer.cornerRadius = 8
        imageButtonDiminatiOutlet.image = UIImage(named: "heartIcon")
        buttonTerjualOutlet.layer.cornerRadius = 8
        imageButtonTerjualOutlet.image = UIImage(named: "dollarIcon")
    }
    
    @IBAction func buttonProdukTapIn(_ sender: Any) {
        buttonProdukOutlet.backgroundColor = UIColor(named: "Purple4")
        buttonDiminatiOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonTerjualOutlet.backgroundColor = UIColor(named: "Purple1")
        daftarJualCollectionView.reloadData()
        daftarJualTableView.isHidden = true
        daftarJualCollectionView.isHidden = false
    }
    
    @IBAction func buttonDiminatiTapIn(_ sender: Any) {
        buttonProdukOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonDiminatiOutlet.backgroundColor = UIColor(named: "Purple4")
        buttonTerjualOutlet.backgroundColor = UIColor(named: "Purple1")
        callOrderAPI.getAllSellerOrder(access_token: access_token, status: "pending") { [weak self](result) in
            guard let _self = self else {return}
            
            switch result {
            case let .success(data):
                _self.diminatiData = data
                _self.daftarJualTableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
    }

    @IBAction func buttonTerjualTapIn(_ sender: Any) {
        buttonProdukOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonDiminatiOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonTerjualOutlet.backgroundColor = UIColor(named: "Purple4")
        callOrderAPI.getAllSellerOrder(access_token: access_token, status: "accepted") { [weak self] (result) in
            guard let _self = self else {return}
            
            switch result {
            case let .success(data):
                _self.diminatiData = data
                _self.daftarJualTableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        daftarJualTableView.reloadData()
        daftarJualTableView.isHidden = false
        daftarJualCollectionView.isHidden = true
    }
}

extension DaftarJualViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diminatiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "DaftarJualTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? DaftarJualTableViewCell else {
            return reusableCell
        }
        
        let diminati = diminatiData[indexPath.row]
        
        if diminati.status == "pending"{
            cell.daftarJualType.text = "Penawaran Produk"
        }else if diminati.status == "accepted"{
            cell.daftarJualType.text = "Berhasil Terjual"
        }else{
            cell.daftarJualType.text = "Gagal Terjual"
        }
        cell.daftarJualName.text = diminati.product_name
        cell.daftarJualPrice.text = "Rp \(diminati.Product!.base_price!.formattedWithSeparator)"
        cell.daftarJualTawar.text = "Ditawar Rp \(String(describing: diminati.price!.formattedWithSeparator))"
        cell.daftarJualDate.text = diminati.transaction_date
        cell.daftarJualImage.loadImage(resource: diminati.Product!.image_url!)

        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produkData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "TambahProduk", for: indexPath)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemGray5.cgColor
            cell.layer.cornerRadius = 4
            
            return cell
        } else {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "DaftarJualCollectionViewCell", for: indexPath) as! DaftarJualCollectionViewCell
            let products = produkData[indexPath.row - 1]
            cell.image.loadImage(resource: products.image_url)
            cell.nama.text = products.name
            cell.tipe.text = products.Categories!.first?.name ?? ""
            cell.harga.text = "Rp \(products.base_price!.formattedWithSeparator)"
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemGray5.cgColor
            cell.layer.cornerRadius = 4
            return cell
        }
    }
}
