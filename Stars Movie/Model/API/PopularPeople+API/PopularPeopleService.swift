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
    
    
    static var images = [String]()
    static var names = [String]()
    
    class func getPopularPeople(page : Int = 1, complation: @escaping (_ JSON : PopularPeople , _ lastPage : Int)-> Void){
        
        let url = URLs.PopularPeopleURL + String(page)
        
            Alamofire.request(url).responseJSON { (response) in
                
            do{
                let JSON = try JSONDecoder().decode(PopularPeople.self , from: response.data!)
                
                var lastPage = Int()
                for data in [JSON] {
                    if let lastp = data.total_pages{
                        lastPage = lastp
                        for data in data.results!{
                            self.images.append(data.profile_path!)
                            self.names.append(data.name!)
                        }
                    }
                }
                
                complation(JSON, lastPage)
            }catch{
                print("error")
            }
        }
    }
}
