//
//  CrewStruct.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct MovieCrew : Codable {
    
    var cast : [Crew]?
}

struct Crew : Codable {
    
    var name : String?
    var profile_path : String?
}
