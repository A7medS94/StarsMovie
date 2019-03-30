//
//  PopularPeopleCell.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class PopularPeopleCell: UICollectionViewCell {

    @IBOutlet weak var popularPersonImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var knownForLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayImg(URL : URL){
        self.popularPersonImage.kf.indicatorType = .activity
        self.popularPersonImage.kf.setImage(with: URL, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }

}
