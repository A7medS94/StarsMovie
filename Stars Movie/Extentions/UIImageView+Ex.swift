//
//  UIImageView+Ex.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/27/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(url: String, placeHolder: String = ""){
        if let url: URL = URL(string: url){
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: UIImage(named: placeHolder), options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
    }
}
