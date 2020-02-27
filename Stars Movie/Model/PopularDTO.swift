//
//  PopularDTO.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

struct PopularDTO: ApiResponseProtocol {
    let page: Int?
    let total_pages: Int?
    let results: [Results]?
    var status_code: Int?
    var success: Bool?
    var status_message: String?
}

struct Results: Codable {
    let id: Int?
    let profile_path: String?
    let name: String?
    let known_for: [KnownFor]?
}

struct KnownFor: Codable {
    let id: Int?
    let title: String?
}
