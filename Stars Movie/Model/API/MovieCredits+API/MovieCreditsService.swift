//
//  MovieCreditsService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class MovieCreditsService {
    
    
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
}
