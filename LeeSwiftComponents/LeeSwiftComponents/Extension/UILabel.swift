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
  
  func addIconToString(_ text: String, icon: UIImage? = nil, y: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil, onLeft: Bool? = true) {
    guard let icon = icon else {
      self.text = text;
      return;
    }
    let attachment = NSTextAttachment(image: icon);
    attachment.bounds = CGRect(x: 0, y: y ?? 0, width: width ?? icon.size.width, height: height ?? icon.size.height);
    
    let fullText = NSMutableAttributedString();
    if onLeft! {
      fullText.append(NSAttributedString(attachment: attachment));
      fullText.append(NSAttributedString(string: text));
    } else {
      fullText.append(NSAttributedString(string: text));
      fullText.append(NSAttributedString(attachment: attachment));
    }
    
    self.attributedText = fullText;
  }
}
