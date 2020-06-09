//
//  SearchVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import RxSwift

class SearchVC: BaseVC {
    
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var viewModel: SearchViewModel!
    
    //MARK: - Vars
    private var cellIdentifier = "SearchPeopleCell"
    private var bag = DisposeBag()
    private var resultData: [ResultData] = [ResultData]()
    private var isloading = false
    private var currentPage = 1
    private var lastPage = 1
    private var searchName: String?
    weak var coordinator: SearchCoordinator?
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Methods
    override func congifureOutLets() {
        self.resultTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.searchBar.delegate = self
        self.resultTableView.dataSource = self
        self.resultTableView.delegate = self
    }
    
    private func loadMore(){
        
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        self.isloading = true
        
        self.startLoading()
        self.viewModel.queryRequest(page: self.currentPage + 1, name: self.searchName!)?.subscribe(onNext: { [weak self] response in
            self?.endLoading()
            if (response.success ?? true) == true{
                for data in response.results!{
                    self?.resultData.append(data)
                }
                self?.isloading = false
                self?.resultTableView.reloadData()
                self?.currentPage += 1
                self?.lastPage = response.total_pages ?? 1
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                self.endLoading()
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
}



extension SearchVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchPeopleCell else {return UITableViewCell()}
        cell.namesLbl.text = resultData[indexPath.row].name ?? ""
        cell.displayImg(URLString: resultData[indexPath.row].profile_path ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let actorId = self.resultData[indexPath.row].id else {return}
        self.coordinator?.goToDetails(actorId: actorId)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let count = self.resultData.count
        if indexPath.row == count-1{
            //load more
            self.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


extension SearchVC : UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchTxt = searchText.replacingOccurrences(of: " ", with: "-")
        self.searchName = searchTxt
        guard !isloading else {return}
        self.isloading = true
        self.resultData.removeAll()
        
        self.startLoading()
        self.viewModel.queryRequest(page: self.currentPage + 1, name: self.searchName!)?.subscribe(onNext: { [weak self] response in
            self?.endLoading()
            if (response.success ?? true) == true{
                self?.resultData = response.results ?? [ResultData]()
                self?.isloading = false
                self?.resultTableView.reloadData()
                self?.currentPage = 1
                self?.lastPage = response.total_pages ?? 1
            }else{
                self?.showErrorMessage(message: response.status_message ?? "")
            }
            }, onError: { (error) in
                self.endLoading()
                print(error.localizedDescription)
        }).disposed(by: self.bag)
    }
}
