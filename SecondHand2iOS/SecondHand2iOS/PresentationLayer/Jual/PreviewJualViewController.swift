//
//  PreviewJualViewController.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 17/06/22.
//

import UIKit

final class PreviewJualViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var terbitkanButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var deskripsiView: UIView!
    @IBOutlet weak var penjualView: UIView!
    
    var currentPage = 0
    var arrBannerImage: [String] = ["AppIcon", "AppIcon", "AppIcon", "AppIcon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        terbitkanButton.clipsToBounds = true
        terbitkanButton.layer.cornerRadius = 16
        configureView(view: productView)
        configureView(view: deskripsiView)
        configureView(view: penjualView)
    }
}

extension PreviewJualViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    private func configureView(view: UIView!){
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.15
        view.layer.masksToBounds = false
    }
}

extension PreviewJualViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 420, height: 476)
    }
}
