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
  
  var smartAttributedString: NSAttributedString {
    if containsEscapedHTML() {
      let decoded = self.htmlUnescaped
      return decoded.htmlToAttributedString;
    } else if containsRawHTML() {
      return self.htmlToAttributedString;
    } else {
      return NSAttributedString(string: self);
    }
  }
  
  var isHTML: Bool {
    return (containsEscapedHTML() || containsRawHTML());
  }
  
  private func containsRawHTML() -> Bool {
    let pattern = "<[^>]+>";
    return self.range(of: pattern, options: .regularExpression) != nil;
  }
  
  private func containsEscapedHTML() -> Bool {
    let pattern = "&lt;(\"[^\"]*\"|'[^']*'|[^'\"&gt;])*&gt;";
    return self.range(of: pattern, options: .regularExpression) != nil;
  }
  
  var htmlUnescaped: String {
    let encodedData = Data(self.utf8);
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue
    ]
    if let attributedString = try? NSAttributedString(data: encodedData, options: options, documentAttributes: nil) {
      return attributedString.string;
    }
    return self;
  }
  
  var htmlToAttributedString: NSAttributedString {
    guard let data = data(using: .utf8) else { return NSAttributedString(string: self) }
    do {
      return try NSAttributedString(
        data: data,
        options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      );
    } catch {
      return NSAttributedString(string: self);
    }
  }
  
  var htmlToString: String {
    return smartAttributedString.string;
  }
  
  var safeURL: URL? {
    if let directURL = URL(string: self), directURL.scheme != nil {
      return directURL;
    }
    
    if let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
       let encodedURL = URL(string: encoded), encodedURL.scheme != nil {
      return encodedURL;
    }
    
    return nil;
  }
}
