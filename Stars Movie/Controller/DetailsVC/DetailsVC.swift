//
//  DetailsVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {

    //Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var placeOfBirthLbl: UILabel!
    @IBOutlet weak var biographyLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var biographyTxtView: UITextView!
    
    //Vars
    var result : Results?
    private var Details : Details?
    private var cellIdentifier = "DetailsCell"
    private var movieCredits : MovieCredit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        handleData()
        requestMovieCredits()
        // Do any additional setup after loading the view.
        navigationBar.topItem?.title = result?.name
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    private func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = navigationBar.barTintColor
        }
    }
    
    private func handleData(){
        DetailsService.getDetails(personID: result?.id ?? 0) { (Details) in
            self.Details = Details
            self.displayImage(imageURL: Details.profile_path ?? "")
            self.displayData(details: Details)
        }
    }
    
    private func displayData(details : Details){
        
        self.nameLbl.text = details.name
        if details.gender == 1 {
            self.genderLbl.text = "Female"
        }
        else {
            self.genderLbl.text = "Male"
        }
        self.birthdayLbl.text = details.birthday
        self.placeOfBirthLbl.text = details.place_of_birth
        self.biographyLbl.text = details.biography
    }
    
    private func displayImage(imageURL : String){
        
        let url = URL(string: URLs.ImageRequestURL + imageURL)
        self.profilePicImage.kf.indicatorType = .activity
        self.profilePicImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
    private func requestMovieCredits(){
        MovieCreditsService.getMovieCredit(personID: result?.id ?? 0) { (movieCredits) in
            
            self.movieCredits = movieCredits
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func seeMoreBtn(_ sender: Any) {
        self.superView.isHidden = false
        self.subView.isHidden = false
        self.biographyTxtView.text = Details?.biography ?? ""
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.superView.isHidden = true
        self.subView.isHidden = true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension DetailsVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCredits?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailsCell  else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: movieCredits?.cast![indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cast = self.movieCredits?.cast![indexPath.row]
  
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "castVC") as! CastVC
        VC.cast = cast
        present(VC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let width = (screenSize-30)/2
        return CGSize.init(width: width, height: width)
    }
}
