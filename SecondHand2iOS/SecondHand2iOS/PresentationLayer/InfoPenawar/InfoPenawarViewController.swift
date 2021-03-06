//
//  InfoPenawarViewController.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 21/06/22.
//

import UIKit

final class InfoPenawarViewController: UIViewController {
    
    @IBOutlet weak var cardBgView: UIView!
    @IBOutlet weak var penawarImageOutlet: UIImageView!
    @IBOutlet weak var namaPembeli: UILabel!
    @IBOutlet weak var kotaPembeli: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let callAPI = SHSellerOrderAPI()
    let access_token = AccessTokenCache.get()
    var produkDitawar = [SHSellerOrderIDResponseModel]()
    var orderID: Int?
    var productID: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        callAPI.getSellerOrderId(access_token: access_token,
                                 id: orderID!) { [weak self] result in
            switch result {
            case let .success(data):
                self?.penawarImageOutlet.setImageFrom(data.User?.image_url ?? "")
                self?.namaPembeli.text = data.User?.full_name
                self?.kotaPembeli.text = data.User?.city
                self?.produkDitawar.append(data)
                self?.tableView.reloadData()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        cardBgViewDesign()
        tableView.register(UINib.init(nibName: "InfoPenawarTableViewCell" , bundle: nil), forCellReuseIdentifier: "InfoPenawarTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func cardBgViewDesign() {
        cardBgView.backgroundColor = UIColor.white
        cardBgView.clipsToBounds = true
        cardBgView.layer.borderColor = UIColor.gray.cgColor
        cardBgView.layer.cornerRadius = 16
        cardBgView.layer.masksToBounds = false
        cardBgView.layer.shadowColor = UIColor.black.cgColor
        cardBgView.layer.shadowOffset = CGSize.zero
        cardBgView.layer.shadowOpacity = 0.15
        cardBgView.layer.shadowRadius = 4
        
        penawarImageOutlet.layer.cornerRadius = 12
    }
    
    @objc func tolakTawaran(_ sender: UIButton){
        callAPI.patchSellerOrderID(
            access_token: access_token,
            id: orderID!,
            status: "declined") { response in
                switch response {
                case .success(let data):
                    print("Tawaran \(data.productName!) berhasil ditolak.")
                    CustomToast.show(
                        message: "Berhasil menolak tawaran.",
                        bgColor: .systemGreen,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    CustomToast.show(
                        message: "Terjadi galat, silahkan coba beberapa saat lagi",
                        bgColor: .systemRed,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                }
            }
    }
    
    @objc func terimaTawaran(_ sender: UIButton){
        callAPI.patchSellerOrderID(
            access_token: access_token,
            id: orderID!,
            status: "accepted") { response in
                switch response {
                case .success(let data):
                    print("Tawaran \(data.productName!) berhasil ditolak.")
                    CustomToast.show(
                        message: "Berhasil menerima tawaran.",
                        bgColor: .systemGreen,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    CustomToast.show(
                        message: "Terjadi galat, silahkan coba beberapa saat lagi",
                        bgColor: .systemRed,
                        textColor: .white,
                        labelFont: .systemFont(ofSize: 17),
                        showIn: .bottom,
                        controller: self)
                }
            }
    }
    
    @objc func openListPickerVC(_ sender: UIButton) {
        let vc = OverlayPenawarView()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.productID = productID
        self.present(vc, animated: true)
    }
}

extension InfoPenawarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produkDitawar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoPenawarTableViewCell", for: indexPath)
        guard let cell = reusableCell as? InfoPenawarTableViewCell else {
            return reusableCell
        }
        cell.selectionStyle = .none
        let dataproduk = produkDitawar[indexPath.row]
        switch dataproduk.status {
        case "pending":
            cell.labelStatusProdukOutlet.text = "Penawaran Produk"
            cell.barangImageOutlet.setImageFrom(dataproduk.image_product ?? "")
            cell.labelNamaProdukOutlet.text = dataproduk.product_name
            cell.labelHargaProdukOutlet.text = "Rp \(String(describing: dataproduk.base_price!.formattedWithSeparator))"
            cell.labelHargaTawarOutlet.text = "Ditawar Rp \(String(describing: dataproduk.price!.formattedWithSeparator))"
            cell.tanggalTransaksiProdukOutlet.text = DateFormatter.convertFromISO(date: dataproduk.transaction_date!)
            cell.buttonStatusOutlet.titleLabel?.text = "Tolak"
            cell.buttonHubungiOutlet.titleLabel?.text = "Terima"
            cell.buttonStatusOutlet.addTarget(self, action: #selector(tolakTawaran(_:)), for: .touchUpInside)
            cell.buttonHubungiOutlet.addTarget(self, action: #selector(terimaTawaran(_:)), for: .touchUpInside)
            return cell
        case "accepted":
            cell.labelStatusProdukOutlet.text = "Penawaran Produk"
            cell.barangImageOutlet.setImageFrom(dataproduk.image_product ?? "")
            cell.labelNamaProdukOutlet.text = dataproduk.product_name
            cell.labelHargaProdukOutlet.text = "Rp \(String(describing: dataproduk.base_price!.formattedWithSeparator))"
            cell.labelHargaTawarOutlet.text = "Rp \(String(describing: dataproduk.price!.formattedWithSeparator))"
            cell.tanggalTransaksiProdukOutlet.text = DateFormatter.convertFromISO(date: dataproduk.transaction_date!)
            cell.buttonStatusOutlet.titleLabel?.text = "Status"
            cell.buttonHubungiOutlet.titleLabel?.text = "Hubungi"
            cell.buttonStatusOutlet.addTarget(self, action: #selector(self.openListPickerVC(_:)), for: .touchUpInside)
            return cell
        case "declined":
            cell.labelStatusProdukOutlet.text = ""
            cell.barangImageOutlet.setImageFrom(dataproduk.image_product ?? "")
            cell.labelNamaProdukOutlet.text = dataproduk.product_name
            cell.labelHargaProdukOutlet.text = "Rp \(String(describing: dataproduk.base_price!.formattedWithSeparator))"
            cell.labelHargaTawarOutlet.text = "Rp \(String(describing: dataproduk.price!.formattedWithSeparator))"
            cell.tanggalTransaksiProdukOutlet.text = DateFormatter.convertFromISO(date: dataproduk.transaction_date!)
            cell.buttonStatusOutlet.isHidden = true
            cell.buttonHubungiOutlet.isHidden = true
            return cell
        default:
            cell.labelStatusProdukOutlet.text = "Penawaran Produk"
            cell.barangImageOutlet.setImageFrom(dataproduk.image_product ?? "")
            cell.labelNamaProdukOutlet.text = dataproduk.product_name
            cell.labelHargaProdukOutlet.text = "Rp \(String(describing: dataproduk.base_price!.formattedWithSeparator))"
            cell.labelHargaTawarOutlet.text = "Rp \(String(describing: dataproduk.price!.formattedWithSeparator))"
            cell.tanggalTransaksiProdukOutlet.text = DateFormatter.convertFromISO(date: dataproduk.transaction_date!)
            cell.buttonStatusOutlet.isHidden = true
            cell.buttonHubungiOutlet.isHidden = true
            return cell
        }
    }
}

extension InfoPenawarViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

