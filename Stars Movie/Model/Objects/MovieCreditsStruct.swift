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
    var id : Int?
}

struct Cast : Codable {
    
    var character : String?
    var credit_id : String?
    var poster_path : String?
    var id : Int?
    var vote_count : Int?
    var backdrop_path : String?
    var original_language : String?
    var original_title : String?
    var popularity : Double?
    var title : String?
    var vote_average : Float?
    var overview : String?
    var release_date : String?
}


