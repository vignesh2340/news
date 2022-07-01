//
//  UIImageView+Extension.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    
    /// Method to check the image is present in cache or not and to download image from url
    /// - Parameters:
    ///   - urlString: denotes imageURl
    ///   - imageMode: denotes content mode
    ///   - activityIndicator: denotes Spinner
    func loadImageUsingCache(withUrl urlString : String, imageMode: UIView.ContentMode, activityIndicator: UIActivityIndicatorView) {
        contentMode = imageMode
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let imageData = data, let image = UIImage(data: imageData) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.stopAnimating()
                    activityIndicator.isHidden = true
                } else {
                    print(urlString)
                }
            }

        }).resume()
    }
}

extension UIView {
    func addGradientBackground() {
        let gradient: CAGradientLayer = CAGradientLayer()
        let endClr = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        gradient.colors = [startColor.cgColor, endClr.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    //Set corner edges for view
    func setCornerEdges(radius: CGFloat = 5) {
        layer.cornerRadius = radius
    }
    
}
