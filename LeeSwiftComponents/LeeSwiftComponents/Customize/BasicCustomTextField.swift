//
//  BasicCustomTextField.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

open class BasicCustomTextField: UITextField {
  
  public var allowedActions: [ResponderStandardEditActions]?;
  
  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
    if let actions = allowedActions {
      return actions.map{ $0.selector }.contains(action);
    }
    
    return super.canPerformAction(action, withSender: sender);
  }
}
