//
//  POPUPVC.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit

class POPUPVC: BaseVC {

    @IBOutlet weak var overViewLbl: UILabel!
    
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.overViewLbl.text = self.message
    }

    
    @IBAction func dismissDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
