//
//  DetailsVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    //Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var result : Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customStatusBar()
        // Do any additional setup after loading the view.
        navigationBar.topItem?.title = result?.name
        
        
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func customStatusBar(){
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = navigationBar.barTintColor
        }
    }
}
