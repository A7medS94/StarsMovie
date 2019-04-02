//
//  SearchQueryService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class SearchQueryService {
    
    
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
