//
//  HomeVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/28/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import RxSwift


class HomeVC: BaseVC {
    
    //MARK: - OutLets
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var viewModel: HomeViewModel!
    
    //MARK: - Vars
    private let bag = DisposeBag()
    private var results: [Results]? = []
    private let cellIdentifier = "PopularPeopleCell"
    lazy var refresher: UIRefreshControl = { () -> UIRefreshControl in
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(getPopular), for: .valueChanged)
        return ref
    }()
    private var isloading = false
    private var currentPage = 1
    private var lastPage = 1
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPopular()
    }
    override func congifureOutLets() {
        self.popularCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.popularCollectionView.refreshControl = self.refresher
        self.popularCollectionView.dataSource = self
        self.popularCollectionView.delegate = self
    }
    
    //MARK: - Methods
    @objc private func getPopular(){
        self.refresher.endRefreshing()
        guard !isloading else {return}
        self.isloading = true
        self.viewModel.popularRequest()?.subscribe(onNext: { [weak self] response in
            
            if (response.success ?? true) == true{
                self?.results = response.results
                self?.lastPage = response.total_pages ?? 1
                self?.isloading = false
                self?.currentPage = 1
                self?.popularCollectionView.reloadData()
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
    
    private func loadMore(){
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        isloading = true
        self.viewModel.popularRequest(page: self.currentPage + 1)?.subscribe(onNext: { [weak self] response in
            
            if (response.success ?? true) == true{
                for data in response.results ?? [Results](){
                    self?.results?.append(data)
                }
                self?.isloading = false
                self?.popularCollectionView.reloadData()
                self?.currentPage += 1
                self?.lastPage = response.total_pages ?? 1
                
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
    
    
    //MARK: - Actions
    @IBAction func searchBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
        present(VC, animated: true, completion: nil)
    }
}



extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PopularPeopleCell else {return UICollectionViewCell()}
        
        cell.popularPersonImage.setImage(url: URLs.ImageRequestURL + (self.results?[indexPath.row].profile_path ?? ""), placeHolder: "placeholder")
        cell.nameLbl.text = self.results?[indexPath.row].name ?? ""
        var knownFor = ""
        for data in self.results?[indexPath.row].known_for ?? [] {
            if let title = data.title{
                knownFor += title
                knownFor += ", "
            }
        }
        cell.knownForLbl.text = knownFor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = self.results![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! DetailsVC
        VC.result = result
        present(VC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.width
        let size = (screenSize - 42)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = self.results?.count
        if indexPath.row == count!-1{
            self.loadMore()
        }
    }
}

