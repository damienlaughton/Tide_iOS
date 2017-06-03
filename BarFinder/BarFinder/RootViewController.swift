//
//  RootViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class RootViewController: UIViewController {

  override func viewDidLoad() {
    self.configure()
  }

  internal func configure() {
    //Do Nothing
  }

  override func prepareForInterfaceBuilder() {
    configure()
    super.prepareForInterfaceBuilder()
  }
  
}
