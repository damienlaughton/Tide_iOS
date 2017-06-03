//
//  UICustomLabel.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class UICustomLabel: UILabel {
  
  var fontName: String { return "Didot" }
  var pointSize: CGFloat { return 13.0 }
  
  // Overide tracking to effect the kerning
  // This number taken directly from JLR spec document
  
  //override this if a subclass is going to ignore the user color
  var overrideColor: UIColor? { return .none }
  
  
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
  
  override func draw(_ rect: CGRect) {
    configure()
    super.drawText(in: rect)
  }
  
  override public var text: String? {
    didSet {
      self.configure()
    }
  }
  
  @IBInspectable var color : UIColor? = .none {
    didSet {
      self.configure()
    }
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
  }
  
  override public init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }
  
  internal func configure() {
    
    font = attributedFont
    textColor = color
    
    if let _overrideColor = overrideColor {
      textColor = _overrideColor
    }
    
    self.configureAttributedText()
  }
  
  func configureAttributedText () {
    let text = self.text ?? ""
    
    let attributedText =  NSAttributedString(string: text, attributes: [NSKernAttributeName:self.kerningValue, NSFontAttributeName:self.attributedFont, NSForegroundColorAttributeName:textColor])
    
    self.attributedText = attributedText
  }
}

