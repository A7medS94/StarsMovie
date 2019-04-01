//
//  MovieCrewService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class MovieCrewService {
    
    
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
}
