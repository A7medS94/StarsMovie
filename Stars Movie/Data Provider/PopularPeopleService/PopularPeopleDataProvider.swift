//
//  PopularPeopleService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class PopularPeopleDataProvider {
    
    
    class func getPopularPeople(page : Int = 1, complation: @escaping (_ popularPeoples : PopularPeople , _ lastPage : Int)-> Void){
        
        let url = URLs.PopularPeopleURL + String(page)
        print(url)
        
        Alamofire.request(url).responseJSON { (response) in
            
            do{
                let JSONdecoder = try JSONDecoder().decode(PopularPeople.self , from: response.data!)
                
                var lastPage = Int()
                
                if let totalPages = JSONdecoder.total_pages{
                    lastPage = totalPages
                }
                
                complation(JSONdecoder, lastPage)
                
            }catch{
                print("error")
            }
        }
    }
    
    class func getDetails(personID : Int , complation: @escaping (_ details : Details)-> Void){
        
        let url = URLs.DetailBaseURL + String(personID) + URLs.DetailEndURL
        
        Alamofire.request(url).responseJSON { (response) in
            
            do{
                let JSONdecoder = try JSONDecoder().decode(Details.self , from: response.data!)
                
                complation(JSONdecoder)
                
            }catch{
                print("error")
            }
        }
    }
    
    class func getMovieCredit(personID : Int , complation: @escaping (_ movieCredits : MovieCredit)-> Void){
        
        let url = URLs.MovieCreditsBaseURL + String(personID) + URLs.MovieCreditsEndURL
        
        Alamofire.request(url).responseJSON { (response) in
            
            do{
                let JSONdecoder = try JSONDecoder().decode(MovieCredit.self , from: response.data!)
                
                complation(JSONdecoder)
                
            }catch{
                print("error")
            }
        }
    }
    
    
    class func getMovieCrew(movieID : Int , complation: @escaping (_ movieCrew : MovieCrew)-> Void){
        
        let url = URLs.MovieCrewBaseURL + String(movieID) + URLs.MovieCrewEndURL
        
        Alamofire.request(url).responseJSON { (response) in
            
            do{
                let JSONdecoder = try JSONDecoder().decode(MovieCrew.self , from: response.data!)
                
                complation(JSONdecoder)
                
            }catch{
                print("error")
            }
        }
    }
    
    
    class func getQuery(page : Int = 1, name : String , complation: @escaping (_ searchQuery : SearchQuery , _ lastPage : Int)-> Void){
        
        let url = URLs.SearchQueryBaseURL + name + URLs.SearchQueryMiddleURL + String(page) + URLs.SearchQueryEndURL
        
        Alamofire.request(url).responseJSON { (response) in
            
            do{
                let JSONdecoder = try JSONDecoder().decode(SearchQuery.self , from: response.data!)
                
                var lastPage = Int()
                
                if let totalPages = JSONdecoder.total_pages{
                    lastPage = totalPages
                }
                
                complation(JSONdecoder, lastPage)
                
            }catch{
                print("error")
            }
        }
    }
}
