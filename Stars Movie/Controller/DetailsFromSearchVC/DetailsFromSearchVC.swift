//
//  DetailsFromSearchVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsFromSearchVC: UIViewController {
    
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
    var person : Result?
    private var Details : Details?
    private var cellIdentifier = "DetailsFromSearchCell"
    private var movieCredits : MovieCredit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        handleData()
        requestMovieCredits()
        // Do any additional setup after loading the view.
        navigationBar.topItem?.title = person?.name ?? "Unknown"
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    ///Returns light status bar content
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    ///Tells the status bar the background color is the same nabigation bar color
    private func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = navigationBar.barTintColor
        }
    }
    ///Getting the popular details data using compilation handler
    private func handleData(){
        DetailsService.getDetails(personID: person?.id ?? 0) { (Details) in
            self.Details = Details
            self.displayImage(imageURL: Details.profile_path ?? "")
            self.displayData(details: Details)
        }
    }
    ///Displaying user data
    private func displayData(details : Details){
        
        self.nameLbl.text = details.name ?? "Unknown"
        if details.gender == 1 {
            self.genderLbl.text = "Female"
        }
        else {
            self.genderLbl.text = "Male"
        }
        self.birthdayLbl.text = details.birthday ?? "Unknown"
        self.placeOfBirthLbl.text = details.place_of_birth ?? "Unknown"
        self.biographyLbl.text = details.biography ?? "Unknown"
    }
    ///Downloading the person image using Alamofire and displaying it
    private func displayImage(imageURL : String){
        
        let url = URL(string: URLs.ImageRequestURL + imageURL)
        self.profilePicImage.kf.indicatorType = .activity
        self.profilePicImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }
    ///Getting the person movies history data using compilation handler
    private func requestMovieCredits(){
        MovieCreditsService.getMovieCredit(personID: person?.id ?? 0) { (movieCredits) in
            
            self.movieCredits = movieCredits
            self.collectionView.reloadData()
        }
    }
    ///Unhide views and displaying bio
    @IBAction func seeMoreBtn(_ sender: Any) {
        self.superView.isHidden = false
        self.subView.isHidden = false
        self.biographyTxtView.text = Details?.biography ?? "Unknown"
    }
    ///hide views
    @IBAction func closeBtn(_ sender: Any) {
        self.superView.isHidden = true
        self.subView.isHidden = true
    }
    ///Dismiss the view controller
    @IBAction func backBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "searchVC")
        present(VC, animated: true, completion: nil)
    }
}



extension DetailsFromSearchVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCredits?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailsFromSearchCell  else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: movieCredits?.cast![indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cast = self.movieCredits?.cast![indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "castFromSearchVC") as! CastFromSearchVC
        VC.cast = cast
        present(VC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let height = CGFloat(131)
        let width = (screenSize-40)/3
        return CGSize.init(width: width, height: height)
    }
}
