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
    
    
    class func getPopularPeople(page : Int = 1, complation: @escaping (_ popularPeoples : PopularPeople , _ lastPage : Int)-> Void){
        
        let url = URLs.PopularPeopleURL + String(page)
        
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
}
