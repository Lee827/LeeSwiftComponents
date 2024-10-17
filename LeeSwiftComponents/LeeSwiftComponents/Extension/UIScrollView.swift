//
//  UIScrollView.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 03/10/2024.
//

public extension UIScrollView {
  func scrollToTop(_ animated: Bool, duration: TimeInterval? = nil) {
    let topOffset = CGPoint(x: 0, y: -contentInset.top);
    if animated, let _duration = duration {
      UIView.animate(withDuration: _duration, animations: {
        self.setContentOffset(topOffset, animated: false);
      });
    } else {
      setContentOffset(topOffset, animated: animated);
    }
  }

  func scrollToBottom(_ animated: Bool, duration: TimeInterval? = nil) {
    let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height);
    if animated, let _duration = duration {
      UIView.animate(withDuration: _duration, animations: {
        self.setContentOffset(bottomOffset, animated: false);
      });
    } else {
      setContentOffset(bottomOffset, animated: animated);
    }
  }
}
