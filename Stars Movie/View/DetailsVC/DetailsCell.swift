//
//  DetailsCell.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayImg(URLString : String){
        
        let url = URL(string: ImageRequestURL + URLString)
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }
}
