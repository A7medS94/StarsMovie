//
//  URLs.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation


class URLs {
    
    ///mark:- API_Key
    static let API_Key = "94e302580d54368e7e936b7fdb9794ab"
    
    ///mark:- Getting Popular People data, takes 3 parameters(API_Key, Language, Page)
    static let PopularPeopleURL = "https://api.themoviedb.org/3/person/popular?api_key=" + URLs.API_Key + "&language=en-US&page="
    
    ///mark:- Base link to request image
    static let ImageRequestURL = "https://image.tmdb.org/t/p/w500"
    
    ///mark:- Base URL for People details
    static let DetailBaseURL = "https://api.themoviedb.org/3/person/"
    
    ///mark:- End URL for People details
    static let DetailEndURL = "?api_key=" + URLs.API_Key + "&language=en-US"
    
    static let MovieCreditsBaseURL = "https://api.themoviedb.org/3/person/"
    
    static let MovieCreditsEndURL = "/movie_credits?api_key=" + URLs.API_Key + "&language=en-US"
    
    static let MovieCrewBaseURL = "https://api.themoviedb.org/3/movie/"
    
    static let MovieCrewEndURL = "/credits?api_key=" + URLs.API_Key
    
}
