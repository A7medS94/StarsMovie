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
    
    ///mark:- Popular People URL, takes 3 parameters(API_Key, Language, Page)
    static let PopularPeopleURL = "https://api.themoviedb.org/3/person/popular?api_key=" + URLs.API_Key + "&language=en-US&page="
    
    ///mark:- Requesting image URL
    static let ImageRequestURL = "https://image.tmdb.org/t/p/w500"
    
    ///mark:- Base URL for People details
    static let DetailBaseURL = "https://api.themoviedb.org/3/person/"
    
    ///mark:- End URL for People details
    static let DetailEndURL = "?api_key=" + URLs.API_Key + "&language=en-US"
    
    ///mark:- Base URL to getting all movies of the person by person ID
    static let MovieCreditsBaseURL = "https://api.themoviedb.org/3/person/"
    
    ///mark:- End URL to getting all movies of the person by person ID
    static let MovieCreditsEndURL = "/movie_credits?api_key=" + URLs.API_Key + "&language=en-US"
    
    ///mark:- Base URL to get all crews by movie ID
    static let MovieCrewBaseURL = "https://api.themoviedb.org/3/movie/"
    
    ///mark:- End URL to get all crews by movie ID
    static let MovieCrewEndURL = "/credits?api_key=" + URLs.API_Key
    
    ///mark:- Base URL for person query search
    static let SearchQueryBaseURL = "https://api.themoviedb.org/3/search/person?api_key=" + URLs.API_Key + "&language=en-US&query="
    
    ///mark:- Middle URL for person query search
    static let SearchQueryMiddleURL = "&page="
    
    ///mark:- End URL for person query search
    static let SearchQueryEndURL = "&include_adult=false"
}
