//
//  DetailsViewModel.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/1/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import Foundation
import RxSwift

class DetailsViewModel: BaseViewModel {
    
    var actorDetailsObservable: Observable<ActorDetailsDTO>?
    var actorMoviesObservable: Observable<MovieCreditDTO>?
    
    func actorDetailsRequest(id: Int)-> Observable<ActorDetailsDTO>?{
        self.actorDetailsObservable = self.provider.rx.request(.getActorDetails(id: id))
            .debug()
            .map(ActorDetailsDTO.self)
            .asObservable()
        return self.actorDetailsObservable
    }
    
    func actorMoviesRequest(id: Int)-> Observable<MovieCreditDTO>?{
        self.actorMoviesObservable = self.provider.rx.request(.getActorMovies(id: id))
            .debug()
            .map(MovieCreditDTO.self)
            .asObservable()
        return self.actorMoviesObservable
    }
}
