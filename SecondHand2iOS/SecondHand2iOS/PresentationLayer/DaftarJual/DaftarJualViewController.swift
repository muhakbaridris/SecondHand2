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
    var access_token: String = AccessTokenCache.get()
    let callProductAPI = SHSellerProductAPI()
    let callOrderAPI = SHSellerOrderAPI()
    
    @IBOutlet var daftarJualTableView: UITableView!
    @IBOutlet var daftarJualCollectionView: UICollectionView!
    
    @IBOutlet var akun: UIView!
    @IBOutlet var akunImg: UIImageView!
    @IBOutlet var namaAkun: UILabel!
    @IBOutlet var btnEditAkunOutlet: UIButton!
    @IBOutlet var kotaAkun: UILabel!
    
    @IBOutlet weak var buttonProdukOutlet: UIButton!
    @IBOutlet weak var imageButtonProdukOutlet: UIImageView!
    @IBOutlet weak var buttonDiminatiOutlet: UIButton!
    @IBOutlet weak var imageButtonDiminatiOutlet: UIImageView!
    @IBOutlet weak var buttonTerjualOutlet: UIButton!
    @IBOutlet weak var imageButtonTerjualOutlet: UIImageView!
    @IBOutlet weak var loadingAnimationOutlet: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        let userData = UserProfileCache.get()
        namaAkun.text = userData?.full_name
        kotaAkun.text = userData?.city
        akunImg.setImageFrom(userData?.image_url ?? "")
        daftarJualTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loadingAnimationOutlet.startAnimating()
        callProductAPI.getAllSellerProduct(access_token: AccessTokenCache.get()) { [weak self] (result) in
            switch result {
            case let .success(data):
                self!.produkData = data
                self!.daftarJualCollectionView.reloadData()
                self!.loadingAnimationOutlet.stopAnimating()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        akunViewDesign()
        stackViewButtonDesign()
        
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
        
        btnEditAkunOutlet.backgroundColor = UIColor.white
        btnEditAkunOutlet.clipsToBounds = true
        btnEditAkunOutlet.layer.borderColor = UIColor(named: "Purple4")!.cgColor
        btnEditAkunOutlet.layer.borderWidth = 1
        btnEditAkunOutlet.layer.cornerRadius = 8
    }
    
    func stackViewButtonDesign(){
        buttonProdukOutlet.layer.cornerRadius = 8
        imageButtonProdukOutlet.image = UIImage(named: "boxIcon")
        buttonDiminatiOutlet.layer.cornerRadius = 8
        imageButtonDiminatiOutlet.image = UIImage(named: "heartIcon")
        buttonTerjualOutlet.layer.cornerRadius = 8
        imageButtonTerjualOutlet.image = UIImage(named: "dollarIcon")
    }
    
    @IBAction func buttonEditAkunTapIn(_ sender: Any) {
        let viewController = UIStoryboard(name: "UbahAkunViewController", bundle: nil).instantiateViewController(withIdentifier: "UbahAkunViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func buttonProdukTapIn(_ sender: Any) {
        buttonProdukOutlet.backgroundColor = UIColor(named: "Purple4")
        buttonDiminatiOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonTerjualOutlet.backgroundColor = UIColor(named: "Purple1")
        callProductAPI.getAllSellerProduct(access_token: AccessTokenCache.get()) { [weak self] (result) in
            switch result {
            case let .success(data):
                self!.produkData = data
                self!.daftarJualCollectionView.reloadData()
                self!.loadingAnimationOutlet.stopAnimating()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        daftarJualTableView.isHidden = true
        daftarJualCollectionView.isHidden = false
    }
    
    @IBAction func buttonDiminatiTapIn(_ sender: Any) {
        buttonProdukOutlet.backgroundColor = UIColor(named: "Purple1")
        buttonDiminatiOutlet.backgroundColor = UIColor(named: "Purple4")
        buttonTerjualOutlet.backgroundColor = UIColor(named: "Purple1")
        callOrderAPI.getAllSellerOrder(access_token: access_token) { [weak self](result) in
            guard let _self = self else {return}
            switch result {
            case let .success(data):
                _self.diminatiData = data
                _self.daftarJualTableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
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
        if diminatiData.count == 0 {
            return 1
        }else{
            return diminatiData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "DaftarJualTableViewCell",
            for: indexPath
        )

        guard let cell = reusableCell as? DaftarJualTableViewCell else {
            return reusableCell
        }
        if diminatiData.count == 0 {
            tableView.allowsSelection = false
            cell.daftarJualName.text = "Tidak ada data"
            cell.daftarJualImage.isHidden = true
            cell.daftarJualImage.backgroundColor = UIColor(named: "Purple4")
            cell.daftarJualType.text = ""
            cell.daftarJualTawar.text = ""
            cell.daftarJualPrice.text = ""
            cell.daftarJualDate.text = ""
            return cell
        } else {
            tableView.allowsSelection = true
            let diminati = diminatiData[indexPath.row]
            if diminati.status == "pending"{
                cell.daftarJualType.text = "Penawaran Produk"
            } else if diminati.status == "accepted" {
                cell.daftarJualType.text = "Berhasil Terjual"
            } else {
                cell.daftarJualType.text = "Gagal Terjual"
            }
            cell.daftarJualName.text = diminati.product_name
            cell.daftarJualPrice.text = "Rp \(diminati.Product!.base_price!.formattedWithSeparator)"
            cell.daftarJualTawar.text = "Ditawar Rp \(String(describing: diminati.price!.formattedWithSeparator))"
            cell.daftarJualDate.text = DateFormatter.convertFromISO(date: diminati.transaction_date!)
            cell.daftarJualImage.isHidden = false
            cell.daftarJualImage.setImageFrom(diminati.Product!.image_url ?? "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diminati = diminatiData[indexPath.row]
        let viewController = UIStoryboard(name: "InfoPenawarViewController",
                                          bundle: nil)
            .instantiateViewController(withIdentifier: "InfoPenawarViewController") as? InfoPenawarViewController
        viewController?.orderID = diminati.id
        self.navigationController?.pushViewController(viewController!, animated: true)
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
            viewController?.pastValue = true
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produkData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "TambahProduk", for: indexPath)
            cell.addLineDashedStroke(pattern: [15, 5], radius: 4, color: UIColor.systemGray2.cgColor)
            return cell
        } else {
            let cell = daftarJualCollectionView.dequeueReusableCell(withReuseIdentifier: "DaftarJualCollectionViewCell", for: indexPath) as! DaftarJualCollectionViewCell
            let products = produkData[indexPath.row - 1]
            cell.image.setImageFrom(products.image_url!)
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
