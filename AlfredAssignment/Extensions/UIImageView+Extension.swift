//
//  UIImageView+Extension.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

extension UIImageView {

    func load(urlString: String) {

        guard let url = URL(string: urlString) else {
            self.image = UIImage()
            return
        }

        guard let image = CacheManager.shared.imageCache.object(forKey: urlString as NSString) else {
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image = image
                    CacheManager.shared.imageCache.setObject(image, forKey: urlString as NSString)
                }
            }
            return
        }
        self.image = image
    }
}
