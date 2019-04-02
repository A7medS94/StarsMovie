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
    private var results: [Results]? = []
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
        DispatchQueue.global(qos: .background).async {
            self.handleRefresh()
        }
        
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        customStatusBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(refresher)
    }
    ///Returns light status bar content
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    ///Tells the status bar the background color is the same nabigation bar color
    func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = navigationBar.barTintColor
        }
    }
    ///Getting the popularPeople data using compilation handler
    @objc private func handleRefresh(){
        
        if Reachability.isConnectedToNetwork(){
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
            }
            guard !isloading else {return}
            isloading = true
            PopularPeopleDataProvider.getPopularPeople { (popularPeoples, lastPage) in
                
                self.results = popularPeoples.results
                self.isloading = false
                self.collectionView.reloadData()
                self.currentPage = 1
                self.lastPage = lastPage
            }
        }else{
            
            let alert = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in
                print("No internet connection")
            }
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    ///Loading more data by adding +1 to page parameter
    fileprivate func loadMore(){
        
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        isloading = true
        PopularPeopleDataProvider.getPopularPeople(page: currentPage+1) { (popularPeoples, lastPage) in
            
            for data in popularPeoples.results!{
                self.results?.append(data)
            }
            self.isloading = false
            self.collectionView.reloadData()
            self.currentPage += 1
            self.lastPage = lastPage
        }
    }
    ///Going to search view controller
    @IBAction func searchBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
        present(VC, animated: true, completion: nil)
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

