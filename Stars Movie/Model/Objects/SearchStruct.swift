//
//  SearchStruct.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct SearchQuery : Codable {
    
    var page : Int?
    var total_pages : Int?
    var results : [Result]?
}

struct Result : Codable {
    
    var id : Int?
    var profile_path : String?
    var name : String?
}
