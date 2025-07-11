//
//  UILabel.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

import Foundation

public extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText);
      attributedString.addAttribute(.kern, value: kernValue, range: NSRange(location: 0, length: labelText.count));
      attributedText = attributedString;
    }
  }
  
  var actualFontSize: CGFloat {
    //initial label
    let fullSizeLabel = UILabel();
    fullSizeLabel.font = self.font;
    fullSizeLabel.text = self.text;
    fullSizeLabel.sizeToFit();
    
    var actualFontSize: CGFloat = self.font.pointSize * (self.bounds.size.width / fullSizeLabel.bounds.size.width);
    
    //correct, if new font size bigger than initial
    actualFontSize = actualFontSize < self.font.pointSize ? actualFontSize : self.font.pointSize;
    
    return actualFontSize;
  }
  
  func setUnderLine() {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText);
      attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length));
      attributedText = attributedString;
    }
  }
  
  func drawBoardDottedLine(width: CGFloat, length: CGFloat, space: CGFloat, cornerRadius: CGFloat, color: UIColor) {
    self.layer.cornerRadius = cornerRadius;
    let borderLayer =  CAShapeLayer();
    borderLayer.bounds = self.bounds;
    
    borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY);
    borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: cornerRadius).cgPath;
    borderLayer.lineWidth = width / UIScreen.main.scale;
    borderLayer.lineDashPattern = [length,space]  as [NSNumber]?;
    borderLayer.lineDashPhase = 0.1;
    
    borderLayer.fillColor = UIColor.clear.cgColor;
    borderLayer.strokeColor = color.cgColor;
    self.layer.addSublayer(borderLayer);
  }
}
