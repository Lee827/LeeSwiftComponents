//
//  UIColor.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension UIColor {
  // Exmaple: UIColor(rgb: 0xFFFFFF)
  convenience init(rgb: Int, alpha: CGFloat = 1.0) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF,
      a: alpha
    );
  }
  
  // Example: UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
  convenience init(red: Int, green: Int, blue: Int, a alpha: CGFloat = 1.0) {
    assert(red >= 0 && red <= 255, "Invalid red component");
    assert(green >= 0 && green <= 255, "Invalid green component");
    assert(blue >= 0 && blue <= 255, "Invalid blue component");
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha);
  }
  
  // Example: UIColor(hexString: "#B20B27")
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted);
    var a, r, g, b: Int32;
    (a, r, g, b) = (255, 0, 0, 0);
    if let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) {
      switch hex.count {
      case 3: // RGB (12-bit)
        (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17);
      case 6: // RGB (24-bit)
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF);
      case 8: // ARGB (32-bit)
        (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF);
      default:
        (a, r, g, b) = (255, 0, 0, 0);
      }
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255);
  }
}
