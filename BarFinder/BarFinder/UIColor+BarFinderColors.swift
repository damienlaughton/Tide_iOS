//
//  UIColor+BarFinderColors.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

extension UIColor {
  class func barLabelFontColor() -> UIColor {
    return thunderbird()
  }

  class func barViewBackground() -> UIColor {
    return UIColor.charcoal_grey()
  }
  
  private class func charcoal_grey() -> UIColor {
    return UIColor(red:0.28, green:0.28, blue:0.22, alpha:1.00)
  }
  
  private class func thunderbird() -> UIColor {
    return UIColor(red:0.75, green:0.20, blue:0.08, alpha:1.00)
  }

}