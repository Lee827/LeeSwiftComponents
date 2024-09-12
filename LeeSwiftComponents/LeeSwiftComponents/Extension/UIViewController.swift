//
//  String.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 12/09/2024.
//

public extension UIViewController {
  func presentOneAlert(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    if let topController = UIApplication.topViewController() {
      guard !topController.isKind(of: UIAlertController.self) else { return; }
    }

    present(viewControllerToPresent, animated: flag, completion: completion);
  }
}
