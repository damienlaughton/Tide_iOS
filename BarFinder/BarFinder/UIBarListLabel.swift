//
//  UIBarListLabel.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class UIBarListLabel: UICustomLabel {
  
  override var pointSize: CGFloat { return 14.0 }
  override var fontTracking: CGFloat { return 50.0 }
  
  override var overrideColor: UIColor? { return UIColor.barLabelFontColor() }
  
}
