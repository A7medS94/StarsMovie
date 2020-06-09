//
//  CastVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import RxSwift

class CastVC: BaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var overviewTxtView: UITextView!
    @IBOutlet weak var characterLbl: UILabel!
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    @IBOutlet weak var viewModel: CastViewModel!
    
    //MARK: - Vars
    private let bag = DisposeBag()
    var cast: Cast?
    private var cellIdentifier = "CrewCell"
    private var movieCast: MovieCastDTO?
    weak var coordinator: CastCoordinator?
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.displayData()
        self.getMovieCast()
    }
    
    //MARK: - Methods
    override func congifureOutLets() {
        self.movieCastCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.movieCastCollectionView.dataSource = self
        self.movieCastCollectionView.delegate = self
    }
    
    private func getMovieCast(){
        self.startLoading()
        self.viewModel.movieCastRequest(castId: (self.cast?.id)!)?.subscribe(onNext: { [weak self] response in
            self?.endLoading()
            if (response.success ?? true) == true{
                self?.movieCast = response
                self?.movieCastCollectionView.reloadData()
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                self.endLoading()
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
    
    private func displayData(){
        self.title = cast?.original_title ?? "Unknown"
        self.releaseLbl.text = "Release(\(cast?.release_date ?? "Unknown"))"
        self.overviewTxtView.text = cast?.overview ?? "Unknown"
        self.characterLbl.text = cast?.character ?? "Unknown"
        let url = ImageRequestURL
        self.backDropImage.setImage(url: url + (self.cast?.backdrop_path ?? ""), placeHolder: "placeholder")
        self.posterImage.setImage(url: url + (self.cast?.poster_path ?? ""), placeHolder: "placeholder")
    }
}



extension CastVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieCast?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CrewCell else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: self.movieCast?.cast![indexPath.row].profile_path ?? "")
        cell.nameLbl.text = self.movieCast?.cast![indexPath.row].name ?? "Unknown"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenSize = UIScreen.main.bounds.width
        let height = CGFloat(131)
        let width = (screenSize-40)/3
        return CGSize.init(width: width, height: height)
    }
}
