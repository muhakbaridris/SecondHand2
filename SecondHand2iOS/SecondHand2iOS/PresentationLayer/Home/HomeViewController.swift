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
    @IBOutlet weak var loadingAnimationOutlet: UIActivityIndicatorView!
    
    private let itemsPerRow: CGFloat = 3
    var access_token: String = AccessTokenCache.get()
    var categoryJSON: [SellerCategoryResponseModel] = []
    var category: [String] = ["Semua"]
    let getAPI = SHBuyerAPI()
    let categoryAPI = SHSellerCategoryAPI()
    let callAuthAPI = SHAuthAPI()
    var responseBuyerOrderAll = [SHAllProductResponseModel]()
    var displayedProduct: [SHAllProductResponseModel] = []
    var searchedProduct : [SHAllProductResponseModel] = []
    var scopeButtons = ""
    @IBOutlet weak var seachBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isUserInteractionEnabled = false
        loadingAnimationOutlet.startAnimating()
        categoryAPI.getSellerCategoryAll { result in
            switch result {
            case let .success(data):
                CategoryCache.save(data)
                self.categoryJSON = data
                print("hasilnya \(self.categoryJSON.count)")
                for i in self.categoryJSON {
                    self.category.append(i.name!)
                }
                self.collectionView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        callAuthAPI.getUserDataSecondHand(access_token: access_token) { [weak self] result in
            switch result {
            case let .success(data):
                print(data)
                UserProfileCache.save(data)
                self?.loadingAnimationOutlet.stopAnimating()
                self?.tabBarController?.tabBar.isUserInteractionEnabled = true
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        print("\n\(UserDefaults.standard.string(forKey: "access_token")!)\n")
        
        getAPI.getAllBuyerProduct(page: 1, perpage: 5) { [weak self](result) in
            guard let _self = self else { return }
            switch result {
            case let .success(data):
                _self.displayedProduct = data
                _self.searchedProduct = _self.displayedProduct
                _self.collectionViewB.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
        
        collectionViewB!.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)

        self.view.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionViewB.dataSource = self
        
        collectionView.delegate = self
        collectionViewB.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return category.count
        } else {
            if scopeButtons == "Semua" || scopeButtons.isEmpty {
                searchedProduct = displayedProduct
                return displayedProduct.count
            } else {
                return searchedProduct.count
            }
        }
    }
    var lastIndexActive:IndexPath = [1 ,0]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            let categories = category[indexPath.row]
            cellA.nameCell.text = categories
            cellA.nameCell.textColor = UIColor.black
            cellA.imageCell.tintColor = .black
            cellA.viewCell.backgroundColor = UIColor(named: "Purple1")
            if indexPath.row == 0 {
                cellA.nameCell.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cellA.viewCell.backgroundColor = UIColor(named: "Purple4")
                cellA.viewCell.layer.masksToBounds = true
                self.lastIndexActive = indexPath
            }
            return cellA
        } else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionCell", for: indexPath) as! HomeProductCollectionCell
            cellB.productName.text = "\((String(describing: searchedProduct[indexPath.row].name!)))"
            cellB.productImage.setImageFrom(searchedProduct[indexPath.row].image_url ?? "")
            cellB.productPrice.text = "Rp \(searchedProduct[indexPath.row].base_price!.formattedWithSeparator)"
            cellB.productType.text = "\(searchedProduct[indexPath.row].Categories!.first?.name ?? "" )"
            cellB.layer.borderWidth = 1
            cellB.layer.borderColor = UIColor.systemGray5.cgColor
            cellB.layer.cornerRadius = 4
            return cellB
        }
    }

    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if self.lastIndexActive != indexPath {
                let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
                cell.nameCell.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.viewCell.backgroundColor = UIColor(named: "Purple4")
                cell.viewCell.layer.masksToBounds = true
                
                scopeButtons = cell.nameCell.text!
                print(scopeButtons)
                searchedProduct.removeAll()
                for i in displayedProduct {
                    if i.Categories!.first?.name! == scopeButtons{
                        searchedProduct.append(i)
                    }
                }
                
                let cell1 = collectionView.cellForItem(at: self.lastIndexActive) as? HomeCollectionViewCell
                cell1?.nameCell.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell1?.viewCell.backgroundColor = UIColor(named: "Purple1")
                cell1?.viewCell.layer.masksToBounds = true
                self.lastIndexActive = indexPath
                collectionViewB.reloadData()
            }
        } else {
            print(indexPath.row)
            let viewController = UIStoryboard(name: "BuyerViewController", bundle: nil).instantiateViewController(withIdentifier: "BuyerViewController") as? BuyerViewController
            viewController?.idBarang = searchedProduct[indexPath.row].id!
            viewController?.namaBarang = searchedProduct[indexPath.row].name!
            viewController?.kategoriBarang = searchedProduct[indexPath.row].Categories!.first?.name ?? ""
            viewController?.hargaBarang = searchedProduct[indexPath.row].base_price!
            viewController?.deskripsiBarang = searchedProduct[indexPath.row].description!
            viewController?.urlGambarBarang = searchedProduct[indexPath.row].image_url!
            viewController?.arrBannerImage = [searchedProduct[indexPath.row].image_url!]
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    private func open(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 215)
    }
    
}
