//
//  UIViewController+Ex.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 2/27/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit

extension UIViewController{
    
    
    func showErrorMessage(message: String, completion: (()->())? = nil){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
