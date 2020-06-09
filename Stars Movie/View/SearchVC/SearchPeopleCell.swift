//
//  SearchPeopleCell.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class SearchPeopleCell: UITableViewCell {
    
    @IBOutlet weak var namesLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.layer.borderWidth = 1
        personImage.layer.masksToBounds = false
        personImage.layer.borderColor = UIColor.black.cgColor
        personImage.layer.cornerRadius = personImage.frame.height/2
        personImage.clipsToBounds = true
        personImage.contentMode = .scaleAspectFill
    }
    
    func displayImg(URLString : String){
        
        let url = URL(string: ImageRequestURL + URLString)
        self.personImage.kf.indicatorType = .activity
        self.personImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
