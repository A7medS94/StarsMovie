//
//  MovieCreditsStruct.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct MovieCredit : Codable {
    
    var cast : [Cast]?
}

struct Cast : Codable {
    
    var character : String?
    var poster_path : String?
    var id : Int?
    var backdrop_path : String?
    var original_title : String?
    var overview : String?
    var release_date : String?
}
