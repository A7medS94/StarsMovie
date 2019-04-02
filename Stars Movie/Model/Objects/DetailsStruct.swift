//
//  DetailStruct.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct Details : Codable {
    
    var birthday : String?
    var id : Int?
    var name : String?
    var gender : Int?
    var biography : String?
    var place_of_birth : String?
    var profile_path : String?
}
