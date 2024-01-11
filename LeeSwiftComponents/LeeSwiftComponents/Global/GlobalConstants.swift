//
//  GlobalConstants.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public struct GlobalConstants {
  public static let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width;
  public static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height;
  public static let SMALL_SIZE_IPHONE_SCREEN_WIDTH: Bool = SCREEN_WIDTH < 375;
  
  public static var SAFE_AREA_INSERT: UIEdgeInsets {
    let window = UIApplication.shared.windows.first;
    return window?.safeAreaInsets ?? UIEdgeInsets.zero;
  }
  
  public static var STATUS_BAR_HEIGHT: CGFloat {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first;
    return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0;
  }
}
