//
//  Seller18ViewController.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 17/06/22.
//

import UIKit

final class Seller18ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var terbitkanButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0
    var arrBannerImage: [String] = ["BannerImage", "AppIcon", "BannerImage", "BannerImage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl?.currentPage = 0
        pageControl?.numberOfPages = arrBannerImage.count
        terbitkanButton.clipsToBounds = true
        terbitkanButton.backgroundColor = UIColor(named: "Purple4")
        terbitkanButton.layer.cornerRadius = 16
    }
}

extension Seller18ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(arrBannerImage.count)
        return arrBannerImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImageCollectionViewCell", for: indexPath) as! BannerImageCollectionViewCell
        cell.bannerImage.image = UIImage(named: arrBannerImage[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension Seller18ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 420, height: 330)
    }
}
