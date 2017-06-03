//
//  DidFinishLaunchingViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class DidFinishLaunchingViewController: RootViewController {

  @IBOutlet weak var titleImageView: UIImageView?
  @IBOutlet weak var logoImageView: UIImageView?
  @IBOutlet weak var titleCenterXConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.performLaunchAnimation(completionHandler: { _ in
      self.launchTabBarController()
    })
  }

  func launchTabBarController() {
    self.performSegue(withIdentifier: "DidFinishLaunchingSegueTabBarController", sender: self)
  }
  
  func performLaunchAnimation(completionHandler: @escaping AnimationCompletionHandler = { _ in }) {
  
    self.animateTitleToTheLeft(animated: true, completionHandler: { _ in
      self.removeLogo(animated: true, completionHandler: { _ in })
        completionHandler(true)
    })
  
  }
  
  func removeLogo(animated: Bool = true, completionHandler: @escaping AnimationCompletionHandler = { _ in }) {
    
    guard let logoImageView = self.logoImageView else { return }
    
    if (!animated) {
      logoImageView.alpha = 0.0
      completionHandler(true)
      return
    }
    
    UIView.animate(withDuration:0.3, delay: 0.0, options: .curveEaseInOut,
                   animations: {
                    logoImageView.alpha = 0.0
    },
                   completion: { finished in
                    completionHandler(true)
    })
    
  }
  
  func animateTitleToTheLeft(animated: Bool = true, completionHandler:@escaping AnimationCompletionHandler = { _ in }) {
  
    guard let titleCenterXConstraint = self.titleCenterXConstraint else { return }
    guard let titleImageView = self.titleImageView else { return }
    
    self.view.layoutIfNeeded()
  
    titleCenterXConstraint.constant = -1.0 * titleImageView.bounds.size.width
    
    if (!animated) {
      self.view.layoutIfNeeded()
      completionHandler(true)
      return
    }
    
    
    UIView.animate(withDuration:0.3, delay: 0.0, options: .curveEaseInOut,
                   animations: {
                    self.view.layoutIfNeeded()
    },
                   completion: { finished in
                    completionHandler(true)
    })
  }



  

}

