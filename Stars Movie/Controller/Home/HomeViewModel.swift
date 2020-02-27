//
//  HomeViewModel.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/17/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel{
    
    var popularObservable: Observable<PopularDTO>?
    
    func popularRequest(page: Int = 1)-> Observable<PopularDTO>?{
        self.popularObservable = self.provider.rx.request(.getPopular(page: page))
            .debug()
            .map(PopularDTO.self)
            .asObservable()
        return self.popularObservable
    }
}
