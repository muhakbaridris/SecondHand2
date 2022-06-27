//
//  BuyerViewController.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 24/06/22.
//

import UIKit

class BuyerViewController: UIViewController {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var penjualView: UIView!
    @IBOutlet weak var deskripsiView: UIView!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var pagerControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentPage = 0
    var arrBannerImage = ["AppIcon", "BannerImage", "BannerImage"]
    
//    var modalVC = UIStoryboard(name: "BuyerViewController", bundle: nil).instantiateViewController(withIdentifier: "HalfPresentationViewController") as? HalfPresentationViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(view: productView)
        configureView(view: penjualView)
        configureView(view: deskripsiView)
        btnBuy.clipsToBounds = true
        btnBuy.layer.cornerRadius = 16
        
    }
    private func configureView(view: UIView) {
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 4
    }
    @IBAction func btnBuyTouchUpInside(_ sender: Any) {
        let vc = OverlayBuyerView()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true)
        
    }
}

extension BuyerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBannerImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyerCollectionViewCell", for: indexPath) as! BuyerCollectionViewCell
        cell.bannerImage.image = UIImage(named: arrBannerImage[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pagerControl.currentPage = currentPage
    }
    
}

extension BuyerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 420, height: 330)
    }
}


extension BuyerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            PresentationController(presentedViewController: presented, presenting: presenting)
        }
}
