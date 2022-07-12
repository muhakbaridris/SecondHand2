//
//  HomeViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit


final class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var textLabelKategori: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelDiskon: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    private let itemsPerRow: CGFloat = 3
    var access_token: String = ""
    let getAPI = SHBuyerAPI()
    var responseBuyerOrderAll = [SHAllProductResponseModel]()
    var displayedProduct: [SHAllProductResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print("\n\(UserDefaults.standard.string(forKey: "access_token")!)\n")
        }
        
        callAuthAPI.getUserDataSecondHand(access_token: access_token) { result in
            switch result {
            case let .success(data):
                UserProfileCache.save(data)
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        

        
        collectionViewB!.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        getAPI.getAllBuyerProduct(page: 1, perpage: 5) { [weak self](result) in
            guard let _self = self else {
                return
            }
            
            switch result {
            case let .success(data):
                _self.displayedProduct = data
                _self.collectionViewB.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }

        self.view.backgroundColor = UIColor.white
        textLabelKategori.text = "Telusuri Kategori"
        headlineLabel.text = "Bulan Ramadhan Banyak diskon!"
        labelDiskon.text = "Diskon Hingga"
        labelPercent.text = "60%"
        collectionView.dataSource = self
        collectionViewB.dataSource = self
        
        collectionView.delegate = self
        collectionViewB.delegate = self
//        collectionViewB.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return carouselButton.count
        }else {
            return displayedProduct.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            cellA.nameCell.text = carouselButton[indexPath.row]
            if carouselButton[indexPath.row] == "Semua" {
                cellA.viewCell.backgroundColor = UIColor(named: "Purple4")
            } else {
                cellA.nameCell.textColor = UIColor.black
                cellA.imageCell.tintColor = .black
                cellA.viewCell.backgroundColor = UIColor(named: "PurpleHalf")
            }
            
            return cellA
        } else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionCell", for: indexPath) as! HomeProductCollectionCell
            let products: SHAllProductResponseModel = displayedProduct[indexPath.row]
            cellB.productName.text = "\(products.name!)"
//            "Rp \((dataproduk.Product.base_price).formattedWithSeparator)"
            cellB.productPrice.text = "Rp \((products.base_price!).formattedWithSeparator)"
            cellB.productImage.loadImage(resource: products.image_url)
            cellB.productType.text = "\(products.Categories!.first!.name!)"
            cellB.layer.borderWidth = 1
            cellB.layer.borderColor = UIColor.black.cgColor
            return cellB
        }
    }

    var lastIndexActive:IndexPath = [1 ,0]

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if self.lastIndexActive != indexPath {
                let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
                cell.nameCell.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.viewCell.backgroundColor = UIColor(named: "Purple4")
                cell.viewCell.layer.masksToBounds = true

                let cell1 = collectionView.cellForItem(at: self.lastIndexActive) as? HomeCollectionViewCell
                cell1?.nameCell.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell1?.viewCell.backgroundColor = UIColor(named: "PurpleHalf")
                cell1?.viewCell.layer.masksToBounds = true
                self.lastIndexActive = indexPath
            }
        } else {
            print(indexPath.row)
            let products: SHAllProductResponseModel = displayedProduct[indexPath.row]
            let viewController = UIStoryboard(name: "BuyerViewController", bundle: nil).instantiateViewController(withIdentifier: "BuyerViewController") as? BuyerViewController
            viewController?.idBarang = products.id!
            viewController?.namaBarang = products.name!
            viewController?.kategoriBarang = products.Categories!.first!.name!
            viewController?.hargaBarang = products.base_price!
            viewController?.deskripsiBarang = products.description!
            viewController?.urlGambarBarang = products.image_url!
            viewController?.arrBannerImage = [products.image_url!]
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    private func open(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    let callAuthAPI = SHAuthAPI()
    var carouselButton: [String] = ["Semua", "Hobi", "Kendaraan"]
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 210)
    }
    
}
