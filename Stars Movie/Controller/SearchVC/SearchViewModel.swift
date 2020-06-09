//
//  SearchViewModel.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModel: BaseViewModel{
    
    var queryObservable: Observable<SearchResultDTO>?
    
    func queryRequest(page: Int = 1, name: String)-> Observable<SearchResultDTO>?{
        self.queryObservable = self.provider.rx.request(.getQuery(page: page, name: name))
            .debug()
            .map(SearchResultDTO.self)
            .asObservable()
        return self.queryObservable
    }
}
