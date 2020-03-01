//
//  Coordinator.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 3/1/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set }
    func start()
}
