//
//  SearchResultDTO.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation

struct SearchResultDTO: ApiResponseProtocol {
    var page : Int?
    var total_pages : Int?
    var results : [ResultData]?
    var success: Bool?
    var status_message: String?
    var status_code: Int?
}

struct ResultData: Codable {
    var id : Int?
    var profile_path : String?
    var name : String?
}
