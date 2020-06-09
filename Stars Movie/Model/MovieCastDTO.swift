//
//  MovieCastDTO.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation

struct MovieCastDTO: ApiResponseProtocol {
    var cast: [CastData]?
    var success: Bool?
    var status_message: String?
    var status_code: Int?
}

struct CastData: Codable {
    var name: String?
    var profile_path: String?
}
