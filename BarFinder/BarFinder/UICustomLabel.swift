//
//  UICustomLabel.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class UICustomLabel: UILabel {
  
  var fontName: String { return "Didcot" }
  var pointSize: CGFloat { return 13.0 }
  
  // Overide tracking to effect the kerning
  // This number taken directly from JLR spec document
  var fontTracking: CGFloat { return 0.0 }
  var kerningValue: CGFloat {
    return (self.pointSize * self.fontTracking) / 1000
  }
  
  var attributedFont: UIFont {
    var _attributtedFont = self.font ?? UIFont.systemFont(ofSize: self.pointSize)
    
    if let __attributtedFont = UIFont(name: self.fontName, size: self.pointSize) {
      _attributtedFont = __attributtedFont
    }
    
    return _attributtedFont
  }
  
  override public var text: String? {
    didSet {
      self.configureAttributedText()
    }
  }
  
  
  @IBInspectable var color : UIColor = UIColor.black {
    didSet {
      self.configureAttributedText()
    }
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    configure()
  }
  
  override public init(frame: CGRect) {
    
    super.init(frame: frame)
    configure()
  }
  
  override func prepareForInterfaceBuilder() {
    configure()
    super.prepareForInterfaceBuilder()
  }
  
  internal func configure() {
    
    font = attributedFont
    textColor = color
    
    self.configureAttributedText()
  }
  
  func configureAttributedText () {
    let text = self.text ?? ""
    
    let attributedText =  NSAttributedString(string: text, attributes: [NSKernAttributeName:self.kerningValue, NSFontAttributeName:self.attributedFont, NSForegroundColorAttributeName:self.color])
    
    self.attributedText = attributedText
  }
}

