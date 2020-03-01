//
//  MovieCreditDTO.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/2/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation

struct MovieCreditDTO: ApiResponseProtocol {
    let cast: [Cast]?
    var success: Bool?
    var status_message: String?
    var status_code: Int?
}

struct Cast: Codable {
    let character: String?
    let poster_path: String?
    let id: Int?
    let backdrop_path: String?
    let original_title: String?
    let overview: String?
    let release_date: String?
}
