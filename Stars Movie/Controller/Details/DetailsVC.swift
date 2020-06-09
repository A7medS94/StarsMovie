//
//  DetailsVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import RxSwift

class DetailsVC: BaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var placeOfBirthLbl: UILabel!
    @IBOutlet weak var biographyLbl: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var viewModel: DetailsViewModel!
    
    //MARK: - Vars
    var actorId: Int?
    private var actorDetails: ActorDetailsDTO?
    private var actorMovies: MovieCreditDTO?
    private var cellIdentifier = "DetailsCell"
    private let bag = DisposeBag()
    weak var coordinator: DetailsCoordinator?
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getActorDetails()
        self.getActorMovies()
    }
    
    override func congifureOutLets() {
        //Setting up OL
        self.moviesCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        //Setting up initial Text
        //Setting up font
    }
    
    //MARK: - Methods
    private func getActorDetails(){
        self.startLoading()
        self.viewModel.actorDetailsRequest(id: self.actorId ?? -1)?.subscribe(onNext: { [weak self] response in
            self?.endLoading()
            if (response.success ?? true) == true{
                self?.actorDetails = response
                self?.setData()
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                self.endLoading()
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
    
    private func getActorMovies(){
        self.startLoading()
        self.viewModel.actorMoviesRequest(id: self.actorId ?? -1)?.subscribe(onNext: { [weak self] response in
            self?.endLoading()
            if (response.success ?? true) == true{
                self?.actorMovies = response
                self?.moviesCollectionView.reloadData()
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                self.endLoading()
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
    
    private func setData(){
        self.title = self.actorDetails?.name ?? "Unkown"
        self.profilePicImage.setImage(url: URLs.ImageRequestURL + (self.actorDetails?.profile_path ?? ""), placeHolder: "placeholder")
        if actorDetails?.gender == 1 {
            self.genderLbl.text = "Female"
        }
        else {
            self.genderLbl.text = "Male"
        }
        self.birthdayLbl.text = actorDetails?.birthday ?? "Unknown"
        self.placeOfBirthLbl.text = actorDetails?.place_of_birth ?? "Unknown"
        self.biographyLbl.text = actorDetails?.biography ?? "Unknown"
    }
    
    //MARK: - Actions
    @IBAction func seeMoreBtn(_ sender: Any) {
        self.overViewPOPUP(message: actorDetails?.biography ?? "Unknown")
    }
}



extension DetailsVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorMovies?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailsCell  else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: actorMovies?.cast![indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cast = self.actorMovies?.cast![indexPath.row]
        self.coordinator?.goToCast(cast: cast!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let height = CGFloat(131)
        let width = (screenSize-40)/3
        return CGSize.init(width: width, height: height)
    }
}
