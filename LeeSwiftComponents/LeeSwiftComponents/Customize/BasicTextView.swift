//
//  BasicTextView.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

/**
 Reference: https://stackoverflow.com/questions/746670/how-to-lose-margin-padding-in-uitextview
 **/
@IBDesignable open class BasicTextView: UITextView {
  override open func layoutSubviews() {
    super.layoutSubviews();
    setup();
  }
  private func setup() {
    textContainerInset = UIEdgeInsets.zero;
    textContainer.lineFragmentPadding = 0;
    contentInset = UIEdgeInsets.zero;
  }
}
