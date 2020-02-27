//
//  UIView+Ex.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/27/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func cornerRedus(value: CGFloat){
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
}
