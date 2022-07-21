//
//  PreviewJualViewController.swift
//  SecondHand2iOS
//
//  Created by Adrian K on 17/06/22.
//

import UIKit

final class PreviewJualViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var namaProdukOutlet: UILabel!
    @IBOutlet weak var kategoriProdukOutlet: UILabel!
    @IBOutlet weak var hargaProdukOutlet: UILabel!
    
    @IBOutlet weak var penjualView: UIView!
    @IBOutlet weak var namaPenjualOutlet: UILabel!
    @IBOutlet weak var kotaPenjualOutlet: UILabel!
    @IBOutlet weak var gambarPenjualOutlet: UIImageView!
    
    @IBOutlet weak var deskripsiView: UIView!
    @IBOutlet weak var deskripsiProdukTextViewOutlet: UITextView!
    
    @IBOutlet weak var buttonTerbitkanOutlet: UIButton!
    
    let callAPI = SHSellerProductAPI()
    let access_token = AccessTokenCache.get()
    
    var jualViewController: JualViewController?
    var currentPage = 0
    var produkName: String = ""
    var produkPrice: String = ""
    var produkKategori: String = ""
    var idKategori: Int = 0
    var namaPenjual: String = ""
    var kotaPenjual: String = ""
    var deskripsiProduk: String = ""
    var imageName: String = ""
    var imageData: UIImage?
    
    public var completion: ((Bool?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id Kategori di preview \(idKategori)")
        namaProdukOutlet.text = produkName
        kategoriProdukOutlet.text = produkKategori
        hargaProdukOutlet.text = "Rp \(Int(produkPrice)!.formattedWithSeparator)"
        let userData = UserProfileCache.get()
        namaPenjualOutlet.text = userData!.full_name
        kotaPenjualOutlet.text = userData!.city
        gambarPenjualOutlet.setImageFrom(userData?.image_url ?? "")
        deskripsiProdukTextViewOutlet.text = deskripsiProduk
        
        buttonTerbitkanOutlet.layer.cornerRadius = 16
        configureView(view: productView)
        configureView(view: deskripsiView)
        configureView(view: penjualView)
    }
    
    @IBAction func buttonTerbitkanTapIn(_ sender: Any) {
        callAPI.postSellerProduct(
            access_token: access_token,
            name: produkName,
            description: deskripsiProduk,
            base_price: Int(produkPrice)!,
            categoryID: idKategori,
            location: UserProfileCache.get().city ?? "",
            imageName: imageName,
            image: imageData!)
        { response in
            switch response {
            case .success(let data):
                print("Upload \(data.name) Success")
                CustomToast.show(message: "Berhasil posting produk.",
                                 bgColor: .systemGreen,
                                 textColor: .white,
                                 labelFont: .systemFont(ofSize: 17),
                                 showIn: .bottom,
                                 controller: self)
                self.completion?(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let err):
                print(err.localizedDescription)
                CustomToast.show(message: "Ada kesalahan pada sistem, silahkan coba lagi beberapa saat lagi.",
                                 bgColor: .systemRed,
                                 textColor: .white,
                                 labelFont: .systemFont(ofSize: 17),
                                 showIn: .bottom,
                                 controller: self)
            }
        }
    }
}

extension PreviewJualViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImageCollectionViewCell", for: indexPath) as! BannerImageCollectionViewCell
        cell.bannerImage.image = imageData
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
