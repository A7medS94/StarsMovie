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
    private let cellIdentifier = "PopularPeopleCell"
    lazy var refresher : UIRefreshControl = { () -> UIRefreshControl in
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return ref
    }()
    var results = [Results]()
    var isloading = false
    var currentPage = 1
    var lastPage = 1
    
    
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
        PopularPeopleService.getPopularPeople { (JSON, lastPage) in
            self.isloading = false
            let JSONDecoder = JSON
            for data in JSONDecoder.results!{
                self.results.append(data)
            }
            self.collectionView.reloadData()
            self.currentPage = 1
            self.lastPage = lastPage
            
        }
    }
    
    fileprivate func loadMore(){
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        isloading = true
        PopularPeopleService.getPopularPeople(page: currentPage+1) { (JSON, lastPage) in
            self.isloading = false
            let JSONDecoder = JSON
            for data in JSONDecoder.results!{
                self.results.append(data)
            }
            self.collectionView.reloadData()
            self.currentPage += 1
            self.lastPage = lastPage
            
        }
    }

}


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PopularPeopleCell else {return UICollectionViewCell()}
        
            cell.popularPersonImage.image = UIImage(named: "placeholder")
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.width
        let width = (screenSize-30)/2
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = self.results.count
        if indexPath.row == count-1{
            //load more
            self.loadMore()
        }
    }
}

