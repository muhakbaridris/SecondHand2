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
    func setup(with product: SHAllProductResponseModelElement){
//        productImage.image = product.image_url
        productName.text = product.name
//        productType.text = product.categories
        productPrice.text = "\(product.base_price)"
    }
}
