//
//  UIApplication.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension UIApplication {
  class var statusBarBackgroundColor: UIColor? {
    get {
      return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor;
    } set {
      (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue;
    }
  }
  
  static func topViewController(controller: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected);
      }
    } else if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController);
    } else if let presented = controller?.presentedViewController {
      return topViewController(controller: presented);
    }
    return controller;
  }
}
