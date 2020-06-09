//
//  CastViewModel.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import RxSwift

class CastViewModel: BaseViewModel{
    
    var movieCastObservable: Observable<MovieCastDTO>?
    
    func movieCastRequest(castId: Int)-> Observable<MovieCastDTO>?{
        self.movieCastObservable = self.provider.rx.request(.getMovieCast(id: castId))
            .debug()
            .map(MovieCastDTO.self)
            .asObservable()
        return self.movieCastObservable
    }
}
