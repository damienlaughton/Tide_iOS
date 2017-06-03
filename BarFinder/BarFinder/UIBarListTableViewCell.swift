//
//  UIBarListTableViewCell.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class UIBarListTableViewCell : UITableViewCell {

  @IBOutlet weak var barNameLabel: UIBarListLabel!
  @IBOutlet weak var distanceLabel: UIBarListLabel!
  
  func configure(bar: Bar) {
      self.barNameLabel.text = bar.barName
      self.distanceLabel.text = bar.distance
  }
  
}
