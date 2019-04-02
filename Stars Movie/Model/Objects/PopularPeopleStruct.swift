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
    var total_pages : Int?
    var results : [Results]?
}

struct Results : Codable {
    
    var id : Int?
    var profile_path : String?
    var name : String?
    var known_for : [KnownFor]?
}

struct KnownFor : Codable {
    
    var id : Int?
    var title : String?
}


