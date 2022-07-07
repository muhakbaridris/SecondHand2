//
//  UIImageView+Extension.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 08/07/22.
//

import UIKit

extension UIImageView {
    func loadImage(resource: URL?) {
        guard let resource = resource else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: resource) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.backgroundColor = .white
            }
        }
    }
    
    func loadImage(resource: String?) {
        backgroundColor = .secondarySystemBackground
        guard let resource = resource, let url = URL(string: resource) else {
            backgroundColor = .white
            return
        }
        loadImage(resource: url)
    }
}
