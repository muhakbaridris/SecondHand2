//
//  UIImageView+Extension.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 08/07/22.
//

import UIKit

extension UIImageView {
      private var activityIndicator: UIActivityIndicatorView {
          let activityIndicator = UIActivityIndicatorView()
          activityIndicator.hidesWhenStopped = true
          activityIndicator.color = UIColor.black
          self.addSubview(activityIndicator)

          activityIndicator.translatesAutoresizingMaskIntoConstraints = false

          let centerX = NSLayoutConstraint(item: self,
                                           attribute: .centerX,
                                           relatedBy: .equal,
                                           toItem: activityIndicator,
                                           attribute: .centerX,
                                           multiplier: 1,
                                           constant: 0)
          let centerY = NSLayoutConstraint(item: self,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: activityIndicator,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 0)
          self.addConstraints([centerX, centerY])
          return activityIndicator
      }

      /// Asynchronous downloading and setting the image from the provided urlString
      func setImageFrom(_ urlString: String, completion: (() -> Void)? = nil) {
          guard let url = URL(string: urlString) else { return }

          let session = URLSession(configuration: .default)
          let activityIndicator = self.activityIndicator

          DispatchQueue.main.async {
              activityIndicator.startAnimating()
          }

          let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
              if let error = error {
                  print(error.localizedDescription)
              } else {
                  if let imageData = data {
                      DispatchQueue.main.async {[weak self] in
                          var image = UIImage(data: imageData)
                          self?.image = nil
                          self?.image = image
                          image = nil
                          completion?()
                      }
                  }
              }
              DispatchQueue.main.async {
                  activityIndicator.stopAnimating()
                  activityIndicator.removeFromSuperview()
              }
              session.finishTasksAndInvalidate()
          }
          downloadImageTask.resume()
      }
}
