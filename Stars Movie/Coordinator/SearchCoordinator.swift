//
//  SearchCoordinator.swift
//  Stars Movie
//
//  Created by Ahmed Samir on 6/9/20.
//  Copyright © 2020 Ahmed Samir. All rights reserved.
//

import UIKit

class SearchCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinatorFromHome: HomeCoordinator?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchVC.instantiate("Main")
        vc.coordinator = self
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetails(actorId: Int){
        let child = DetailsCoordinator(navigationController: navigationController)
        child.parentCoordinatorFromSearch = self
        childCoordinators.append(child)
        child.start(actorId: actorId)
    }
    
    
    
    //MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a OnBoardVC
        //       if let onBoardVC = fromViewController as? OnBoardVC {
        //           // We're popping a OnBoardVC; end its coordinator
        //           childDidFinish(onBoardVC.coordinator)
        //       }
    }
}
