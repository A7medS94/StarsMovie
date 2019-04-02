//
//  CastFromSearchVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class CastFromSearchVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var overviewTxtView: UITextView!
    @IBOutlet weak var characterLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Vars
    var cast : Cast?
    private var movieCrew : MovieCrew?
    private var cellIdentifier = "CrewFromSearchCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        displayData()
        navigationBar.topItem?.title = cast?.original_title ?? "Unknown"
        requestMovieCrew()
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
    ///Dismiss the view controller
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    ///Downloading the cover image using Alamofire and displaying it
    private func displaybackdrop(){
        
        let url = URL(string: URLs.ImageRequestURL + (cast!.backdrop_path ?? ""))
        self.backDropImage.kf.indicatorType = .activity
        self.backDropImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    ///Downloading the poster image using Alamofire and displaying it
    private func displayposter(){
        
        let url = URL(string: URLs.ImageRequestURL + (cast!.poster_path ?? ""))
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }
    ///Displaying movie data data
    private func displayData(){
        self.displaybackdrop()
        self.displayposter()
        releaseLbl.text = "Release(\(cast?.release_date ?? "Unknown"))"
        overviewTxtView.text = cast?.overview ?? "Unknown"
        characterLbl.text = cast?.character ?? "Unknown"
    }
    ///Getting the movie crews data using compilation handler
    private func requestMovieCrew(){
        
        PopularPeopleDataProvider.getMovieCrew(movieID : cast?.id ?? 0) { (movieCrew) in
            
            self.movieCrew = movieCrew
            self.collectionView.reloadData()
        }
    }
}



extension CastFromSearchVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCrew?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CrewFromSearchCell else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: movieCrew?.cast![indexPath.row].profile_path ?? "")
        cell.nameLbl.text = movieCrew?.cast![indexPath.row].name ?? "Unknown"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let height = CGFloat(131)
        let width = (screenSize-40)/3
        return CGSize.init(width: width, height: height)
    }
}
