//
//  CastVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Kingfisher

class CastVC: UIViewController {

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
    private var cellIdentifier = "CrewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        displayData()
        navigationBar.topItem?.title = cast?.original_title
        requestMovieCrew()
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
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func displaybackdrop(){
        
        let url = URL(string: URLs.ImageRequestURL + (cast!.backdrop_path ?? ""))
        self.backDropImage.kf.indicatorType = .activity
        self.backDropImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    private func displayposter(){
        
        let url = URL(string: URLs.ImageRequestURL + (cast!.poster_path ?? ""))
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.flipFromTop(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
    private func displayData(){
        self.displaybackdrop()
        self.displayposter()
        releaseLbl.text = "Release(\(cast?.release_date ?? ""))"
        overviewTxtView.text = cast?.overview ?? ""
        characterLbl.text = cast?.character ?? ""
    }
    
    private func requestMovieCrew(){
        
        MovieCrewService.getMovieCrew(movieID : cast?.id ?? 0) { (movieCrew) in
            
            self.movieCrew = movieCrew
            self.collectionView.reloadData()
        }
    }
}



extension CastVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCrew?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CrewCell else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: movieCrew?.cast![indexPath.row].profile_path ?? "")
        cell.nameLbl.text = movieCrew?.cast![indexPath.row].name ?? ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let width = (screenSize-30)/2
        return CGSize.init(width: width, height: width)
    }
}
