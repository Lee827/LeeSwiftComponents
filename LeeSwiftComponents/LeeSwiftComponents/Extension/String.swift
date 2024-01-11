//
//  String.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension String {
  var decode: String {
    return self.replacingOccurrences(of: "&ldquo;", with: "\"");
  }
  
  var decodeMultiline: String {
    return self.replacingOccurrences(of: "\\n", with: "\n");
  }
  
  var hasWhiteSpace: Bool {
    return self.contains(" ");
  }
  
  func removingWhitespaces() -> String {
    return components(separatedBy: .whitespaces).joined();
  }
  
  var htmlToAttributedString: NSAttributedString {
    guard let data = data(using: .utf8) else { return NSAttributedString() }
    do {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                          .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil);
    } catch {
      return NSAttributedString();
    }
  }
  
  var htmlToString: String {
    return htmlToAttributedString.string;
  }
  
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude);
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil);
    
    return ceil(boundingBox.height);
  }
  
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height);
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil);
    
    return ceil(boundingBox.width);
  }
  
  func lineSpaced(_ spacing: CGFloat, label: UILabel) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle();
    paragraphStyle.lineSpacing = spacing - label.font.pointSize - (label.font.lineHeight - label.font.pointSize);
    paragraphStyle.lineBreakMode = .byTruncatingTail;
    let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]);
    return attributedString;
  }
}
