//
//  DidFinishLaunchingViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class DidFinishLaunchingViewController: RootViewController {

  @IBOutlet weak var logoImageView: UIImageView!

  func launchTabBarController() {
    self.performSegue(withIdentifier: "DidFinishLaunchingSegueTabBarController", sender: self)
  }
  
  func removeLogo(animated: Bool = true, completionHandler: @escaping AnimationCompletionHandler = { _ in }) {
    
    guard let logoImageView = self.logoImageView else { return }
    
    if (!animated) {
      logoImageView.alpha = 0.0
      completionHandler(true)
      return
    }
    
    UIView.animate(withDuration:1.0, delay: 0.0, options: .curveEaseInOut,
                   animations: {
                    logoImageView.alpha = 0.0
    },
                   completion: { finished in
                    completionHandler(true)
    })
    
  }


  

}

