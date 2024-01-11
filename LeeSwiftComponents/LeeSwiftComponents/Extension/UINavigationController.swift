//
//  UINavigationController.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension UINavigationController {
  private func doAfterAnimatingTransition(animated: Bool, completion: @escaping (() -> Void)) {
    if let coordinator = transitionCoordinator, animated {
      coordinator.animate(alongsideTransition: nil, completion: { _ in
        completion();
      })
    } else {
      DispatchQueue.main.async {
        completion();
      }
    }
  }
  
  func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping (() -> Void)) {
    let _viewController = self.topViewController;
    if self.viewControllers.count >= 1 {
      _viewController?.hidesBottomBarWhenPushed = true;
    }
    pushViewController(viewController, animated: animated);
    if self.viewControllers.count <= 2 {
      _viewController?.hidesBottomBarWhenPushed = false;
    }
    doAfterAnimatingTransition(animated: animated, completion: completion);
  }
  
  func popViewController(animated: Bool, completion: @escaping (() -> Void)) {
    popViewController(animated: animated);
    doAfterAnimatingTransition(animated: animated, completion: completion);
  }
  
  func popToRootViewControllerAnimated(animated: Bool, completion: @escaping (() -> Void)) {
    popToRootViewController(animated: animated);
    doAfterAnimatingTransition(animated: animated, completion: completion);
  }
  
  static func navBarHeight() -> CGFloat {
    let nVc = UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil));
    let navBarHeight = nVc.navigationBar.frame.size.height;
    return navBarHeight;
  }
}
