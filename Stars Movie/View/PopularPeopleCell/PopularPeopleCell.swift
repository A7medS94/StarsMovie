//
//  PopularPeopleCell.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit

class PopularPeopleCell: UICollectionViewCell {
    
    @IBOutlet weak var popularPersonImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var knownForLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.cornerRedus(value: 4)
    }
}
