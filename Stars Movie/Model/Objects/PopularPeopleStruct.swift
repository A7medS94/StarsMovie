//
//  PopularPeopleStruct.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct PopularPeople : Codable {
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [Results]?
}

struct Results : Codable {
    var popularity : Double?
    var id : Int?
    var profile_path : String?
    var name : String?
    var known_for : [KnownFor]?
    var adult : Bool?
}

struct KnownFor : Codable {
    var vote_average : Float?
    var vote_count : Int?
    var id : Int?
    var media_type : String?
    var title : String?
    var popularity : Float?
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var backdrop_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    
}
