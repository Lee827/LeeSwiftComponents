//
//  BasicCustomTextField.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

open class BasicCustomTextField: UITextField {
  
  public var allowedActions: [ResponderStandardEditActions]?;
  public var textPaddingInsets: UIEdgeInsets?;

  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
    if let actions = allowedActions {
      return actions.map{ $0.selector }.contains(action);
    }
    
    return super.canPerformAction(action, withSender: sender);
  }
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    guard let insets = textPaddingInsets else { return super.textRect(forBounds: bounds); }
    return bounds.inset(by: insets);
  }
}
