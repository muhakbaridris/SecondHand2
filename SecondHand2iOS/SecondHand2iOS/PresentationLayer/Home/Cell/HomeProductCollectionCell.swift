//
//  HomeProductCollectionCell.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 16/06/22.
//

import UIKit

class HomeProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    func setup(with product: Product){
        productImage.image = product.productImage
        productName.text = product.productName
        productType.text = product.productType
        productPrice.text = product.productPrice
    }
}
