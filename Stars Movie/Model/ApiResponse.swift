//
//  ApiResponse.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/17/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation

protocol ApiResponseProtocol: Codable {
    var success: Bool? { get }
    var status_message: String? { get }
    var status_code: Int? { get }
}
