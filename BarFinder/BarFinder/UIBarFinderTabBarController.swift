//
//  UIBarFinderTabBarController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

// I decided to do it this way because 1 - it takes code out of the app delegate
// 2. In a funky world we might have two styles of tab bar (but lets hope not) so this way we dont use the global tint color

@IBDesignable class UIBarFinderTabBarController : UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configure()
  }
  
  func configure() {
    self.tabBar.tintColor =  UIColor.barLabelFontColor()
  }
  
  override func prepareForInterfaceBuilder() {
    self.configure()
    
    super.prepareForInterfaceBuilder()
  }
  
}
