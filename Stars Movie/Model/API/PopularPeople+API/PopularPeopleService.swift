//
//  PopularPeopleService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/29/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class PopularPeopleService {
    
    
    class func getPopularPeople(page : Int = 1, complation: @escaping (_ JSON : PopularPeople , _ lastPage : Int)-> Void){
        
        let url = URLs.PopularPeopleURL
        
        let parameters : [String: Any] = [
            "api_key" : URLs.API_Key,
            "language": "en-US",
            "page"    : page
        ]
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            do{
                let JSON = try JSONDecoder().decode(PopularPeople.self , from: response.data!)
                
                var lastPage = Int()
                for data in [JSON] {
                    if let lastp = data.total_pages{
                        lastPage = lastp
                    }
                }
                
                complation(JSON, lastPage)
            }catch{
                print("error")
            }
        }
    }
}
