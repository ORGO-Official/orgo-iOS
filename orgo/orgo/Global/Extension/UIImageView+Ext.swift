//
//  UIImageView+Ext.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// 이미지 캐시 처리 + setImage
    func setImage(with urlString: String) {
        ImageCache.default.retrieveImage(forKey: urlString, options: nil) { result in
            switch result {
            case .success(let value):
                if let image = value.image {
                    //캐시가 존재하는 경우
                    self.image = image
                } else {
                    //캐시가 존재하지 않는 경우
                    guard let url = URL(string: urlString) else { return }
                    let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
                    self.kf.setImage(with: resource)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
