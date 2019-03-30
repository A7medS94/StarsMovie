//
//  ViewController.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/28/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit


class MainVC: UIViewController {

    //Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Vars
    var results: [Results]? = []
    private let cellIdentifier = "PopularPeopleCell"
    lazy var refresher : UIRefreshControl = { () -> UIRefreshControl in
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return ref
    }()
    private var isloading = false
    private var currentPage = 1
    private var lastPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(refresher)
        
        handleRefresh()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = navigationBar.barTintColor
        }
    }
    
    @objc private func handleRefresh(){
        
        self.refresher.endRefreshing()
        guard !isloading else {return}
        isloading = true
        PopularPeopleService.getPopularPeople { (popularPeoples, lastPage) in
            
            self.results = popularPeoples.results
            self.isloading = false
            self.collectionView.reloadData()
            self.currentPage = 1
            self.lastPage = lastPage
        }
    }
    
    fileprivate func loadMore(){
        
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        isloading = true
        PopularPeopleService.getPopularPeople(page: currentPage+1) { (popularPeoples, lastPage) in
            
            for data in popularPeoples.results!{
                self.results?.append(data)
            }
            self.isloading = false
            self.collectionView.reloadData()
            self.currentPage += 1
            self.lastPage = lastPage
        }
    }

}



extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.results!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PopularPeopleCell else {return UICollectionViewCell()}
        
        cell.displayImg(URLString: self.results?[indexPath.row].profile_path ?? "")
        cell.nameLbl.text = self.results?[indexPath.row].name ?? ""
        var knownFor = ""
        for data in self.results?[indexPath.row].known_for ?? [] {
            knownFor += data.title ?? ""
            knownFor += ", "
        }
        cell.knownForLbl.text = knownFor
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///Result Object
        let result = self.results![indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! DetailsVC
        VC.result = result
        present(VC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let width = (screenSize-30)/2
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let count = self.results?.count
        if indexPath.row == count!-1{
            //load more
            self.loadMore()
        }
    }
}

