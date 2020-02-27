//
//  BaseVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/17/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit
import IHProgressHUD

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.congifureOutLets()
    }
    
    func congifureOutLets(){
        
    }
    
    private func loadingConfg(){
        IHProgressHUD.set(foregroundColor: .blue)
        IHProgressHUD.set(ringThickness: 5)
        IHProgressHUD.set(defaultStyle: .light)
        IHProgressHUD.set(defaultMaskType: .custom)
        IHProgressHUD.set(backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        IHProgressHUD.setHUD(backgroundColor: .white)
    }
    private func startAnimatingNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.view.isUserInteractionEnabled = true
    }
    
    private func stopAnimatingNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.view.isUserInteractionEnabled = true
    }
    
    func startLoading(){
        self.loadingConfg()
        IHProgressHUD.show()
        self.startAnimatingNetworkActivity()
    }
    func endLoading(){
        IHProgressHUD.dismiss()
        self.stopAnimatingNetworkActivity()
    }
}
