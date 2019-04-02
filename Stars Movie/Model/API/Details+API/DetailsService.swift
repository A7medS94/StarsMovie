//
//  DetailsService.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation
import Alamofire


class DetailsService {
    
    
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
}

