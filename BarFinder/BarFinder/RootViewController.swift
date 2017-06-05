//
//  RootViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class RootViewController: UIViewController {

  @IBOutlet weak var debugLabelHeightConstraint: NSLayoutConstraint?

  override func viewDidLoad() {
    self.configure()
  }

  internal func configure() {
    //Do Nothing
    
    self.configDebugLabel()
  }
  
  func configDebugLabel() {
  
//  Re-Instate the degub Label by switching the code blocks
  
  self.debugLabelHeightConstraint?.constant = 0.0
  
//    #if DEBUG
//      self.debugLabelHeightConstraint?.constant = 100.0
//    #else
//      self.debugLabelHeightConstraint?.constant = 0.0
//    #endif
  }

  override func prepareForInterfaceBuilder() {
    configure()
    super.prepareForInterfaceBuilder()
  }
  
}
