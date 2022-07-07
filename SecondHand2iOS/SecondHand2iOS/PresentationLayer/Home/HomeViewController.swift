//
//  HomeViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 13/06/22.
//

import UIKit

struct Product {
    let productImage: UIImage
    let productName: String
    let productType: String
    let productPrice: String
}

final class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return carouselButton.count
        }else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            cellA.nameCell.text = carouselButton[indexPath.row]
            if carouselButton[indexPath.row] == "Semua" {
                cellA.viewCell.backgroundColor = UIColor(named: "Purple4")
            }else{
                cellA.nameCell.textColor = UIColor.black
                cellA.imageCell.tintColor = .black
                cellA.viewCell.backgroundColor = UIColor(named: "PurpleHalf")
            }
            
            return cellA
        }else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionCell", for: indexPath) as! HomeProductCollectionCell
            cellB.setup(with: products[indexPath.row])
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
        }else{
            let viewController = UIStoryboard(name: "BuyerViewController", bundle: nil).instantiateViewController(withIdentifier: "BuyerViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func open(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBOutlet weak var textLabelKategori: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelDiskon: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    private let itemsPerRow: CGFloat = 3
    var access_token: String = ""
    
    var carouselButton: [String] = ["Semua", "Hobi", "Kendaraan"]
    let products: [Product] = [
        Product(productImage: UIImage(named: "AppIconImage")!, productName: "Jam Tangan Casio", productType: "Aksesoris", productPrice: "Rp 250.000"),
        Product(productImage: UIImage(named: "AppIconImage")!, productName: "Smartwatch Samsung", productType: "Aksesoris", productPrice: "Rp 3.550.000")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "access_token") != nil {
            access_token = UserDefaults.standard.string(forKey: "access_token")!
            print(UserDefaults.standard.string(forKey: "access_token")!)
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
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 156, height: 210)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: collectionView.frame.size.width/1, height: collectionView.frame.size.height/1)

        }
}
