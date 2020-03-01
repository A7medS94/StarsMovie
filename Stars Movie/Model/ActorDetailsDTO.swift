//
//  ActorDetailsDTO.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/2/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation

struct ActorDetailsDTO: ApiResponseProtocol {
    let birthday: String?
    let id: Int?
    let name: String?
    let gender: Int?
    let biography: String?
    let place_of_birth: String?
    let profile_path: String?
    var success: Bool?
    var status_message: String?
    var status_code: Int?
    
}
