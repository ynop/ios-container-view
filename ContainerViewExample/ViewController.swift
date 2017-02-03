//
//  ViewController.swift
//  ContainerViewExample
//
//  Created by Matthias Büchi on 03/02/17.
//  Copyright © 2017 ynop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    private var currentController : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCurrentController(name: "ctrl1")
    }

    @IBAction func goHome(_ sender: Any) {
        self.setCurrentController(name: "ctrl1")
    }
    
    @IBAction func goTable(_ sender: Any) {
        self.setCurrentController(name: "ctrl2")
    }
    
    @IBAction func goSingle(_ sender: Any) {
        self.setCurrentController(name: "ctrl3")
    }
    
    func setCurrentController(name : String){
        
        // Remove current view controller if one is embedded
        if self.currentController != nil {
            self.currentController.willMove(toParentViewController: nil)
            self.currentController.view.removeFromSuperview()
            self.currentController.removeFromParentViewController()
            self.currentController.didMove(toParentViewController: nil)
        }
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let ctrl = storyboard.instantiateViewController(withIdentifier: name)
        
        ctrl.view.translatesAutoresizingMaskIntoConstraints = false
        ctrl.willMove(toParentViewController: self)
        self.containerView.addSubview(ctrl.view)
        
        // Set constraints so the embedded view matches the container's size
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: ctrl.view.leadingAnchor, constant: 0),
            self.containerView.trailingAnchor.constraint(equalTo: ctrl.view.trailingAnchor, constant: 0),
            self.containerView.topAnchor.constraint(equalTo: ctrl.view.topAnchor, constant: 0),
            self.containerView.bottomAnchor.constraint(equalTo: ctrl.view.bottomAnchor, constant: 0),
            ])
        
        self.addChildViewController(ctrl)
        ctrl.didMove(toParentViewController: self)
        
        self.currentController = ctrl
    }
}

