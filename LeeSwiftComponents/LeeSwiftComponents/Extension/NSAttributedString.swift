//
//  String.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 12/09/2024.
//

public extension NSAttributedString {
  func lineSpaced(_ spacing: CGFloat, textView: UITextView) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle();
    guard let font = textView.font else { return NSMutableAttributedString(attributedString: self) }
    paragraphStyle.lineSpacing = spacing - font.pointSize - (font.lineHeight - font.pointSize);
    
    let attributedString = NSMutableAttributedString(attributedString: self);
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length));
    
    return attributedString;
  }
}
