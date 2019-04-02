//
//  SearchVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 4/1/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subView: UIView!
    
    //Vars
    private var cellIdentifier = "SearchPeopleCell"
    private var result: [Result]? = []
    private var isloading = false
    private var currentPage = 1
    private var lastPage = 1
    private var searchName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        customStatusBar()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.becomeFirstResponder()
        
    }
    ///Returns light status bar content
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    ///Tells the status bar the background color is the same nabigation bar color
    func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = searchBar.barTintColor
        }
    }
    ///Loading more data by adding +1 to page parameter
    fileprivate func loadMore(){
        
        guard !isloading else {return}
        guard currentPage < lastPage else {return}
        isloading = true
        
        SearchQueryService.getQuery(page: currentPage+1, name: searchName!) { (searchQuery, lastPage) in
            
            for data in searchQuery.results!{
                self.result?.append(data)
            }
            self.isloading = false
            self.tableView.reloadData()
            self.currentPage += 1
            self.lastPage = lastPage
        }
    }
}



extension SearchVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchPeopleCell else {return UITableViewCell()}
        cell.namesLbl.text = result![indexPath.row].name ?? ""
        cell.displayImg(URLString: result?[indexPath.row].profile_path ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = self.result![indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "detailsFromSearchVC") as! DetailsFromSearchVC
        VC.person = person
        present(VC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let count = self.result?.count
        if indexPath.row == count!-1{
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "mainVC")
        present(VC, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if Reachability.isConnectedToNetwork(){
            
            let searchTxt = searchText.replacingOccurrences(of: " ", with: "-")
            self.searchName = searchTxt
            guard !isloading else {return}
            isloading = true
            SearchQueryService.getQuery(name: searchTxt) { (searchQuery, lastpage) in
                self.result = searchQuery.results
                self.isloading = false
                self.tableView.reloadData()
                self.currentPage = 1
                self.lastPage = lastpage
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
}



