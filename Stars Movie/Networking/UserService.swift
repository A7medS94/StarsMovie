//
//  UserService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/17/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import Moya

let apiKey = "94e302580d54368e7e936b7fdb9794ab"
let ImageRequestURL = "https://image.tmdb.org/t/p/w500"

enum UserService{
    case getPopular(page: Int)
    case getActorDetails(id: Int)
    case getActorMovies(id: Int)
    case getMovieCast(id: Int)
    case getQuery(page: Int, name: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getPopular(_):
            return "/person/popular"
        case .getActorDetails(let id):
            return "/person/\(id)"
        case .getActorMovies(let id):
            return "/person/\(id)/movie_credits"
        case .getMovieCast(let id):
            return "/movie/\(id)/credits"
        case .getQuery(_,_):
            return "/search/person"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopular(_), .getActorDetails(_), .getActorMovies(_), .getMovieCast(_), .getQuery(_,_):
            return .get

        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .getPopular(_), .getQuery(_,_):
            return URLEncoding.queryString
        default:
            return URLEncoding.default
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPopular(let page):
            return .requestParameters(parameters: ["api_key":apiKey,"language":"en-US","page":page], encoding: URLEncoding.default)
        case .getActorDetails(_), .getActorMovies(_), .getMovieCast(_):
            return .requestParameters(parameters: ["api_key":apiKey,"language":"en-US"], encoding: URLEncoding.default)
        case .getQuery(let page, let name):
            return .requestParameters(parameters: ["api_key":apiKey,"language":"en-US","query":name,"page":page,"include_adult":"false"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
