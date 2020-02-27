//
//  BaseViewModel.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/17/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BaseViewModel: NSObject{
    
    let provider: MoyaProvider<UserService>
    
    let endpointClosure = { (target: UserService) -> Endpoint in
        
        let url = target.baseURL.absoluteString + target.path
        let endPoint = Endpoint(url: url,
                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
        
        print(endPoint.url)
        print(endPoint.task)
        print(endPoint.method)
        print(endPoint.httpHeaderFields ?? ["":""])
        
        return endPoint
    }
    override init() {
        self.provider = MoyaProvider<UserService>(endpointClosure: endpointClosure)
    }
}
