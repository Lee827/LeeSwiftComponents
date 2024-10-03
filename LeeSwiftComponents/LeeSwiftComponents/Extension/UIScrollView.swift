//
//  UIScrollView.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 03/10/2024.
//

public extension UIScrollView {
  func scrollToTop(_ animated: Bool) {
    let topOffset = CGPoint(x: 0, y: -contentInset.top);
    setContentOffset(topOffset, animated: animated);
  }

  func scrollToBottom(_ animated: Bool) {
    let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height);
    setContentOffset(bottomOffset, animated: animated);
  }
}
