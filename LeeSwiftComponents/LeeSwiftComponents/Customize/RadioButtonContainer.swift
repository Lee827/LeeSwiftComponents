//
//  RadioButtonContainer.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 29/01/2024.
//

public protocol RadioButtonDelegate: AnyObject {
  func didSelectedButton(_ selectedButton: CustomRadioButton, value: Any);
}

open class RadioButtonContainer: UIView {
  public var radioButtons = [CustomRadioButton]();
  var titles: [String] = [];
  var values: [Any] = [];
  weak public var delegate: RadioButtonDelegate?;
  var currentSelectedButton: CustomRadioButton? = nil;
  
  required public init(titles: [String], values: [Any], titleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular), titleColor: UIColor = .gray, dotColor: UIColor = .black, borderColor: UIColor = .gray, borderWidth: CGFloat = 1, borderSize: CGFloat = 16, dotSize: CGFloat = 12, titleSpacing: CGFloat = 32, buttonSpacing: CGFloat = 8) {
    self.titles = titles;
    self.values = values;
    super.init(frame: CGRect.zero);
    self.isUserInteractionEnabled = true;
    
    for (i, title) in titles.enumerated() {
      let radioButton = CustomRadioButton(borderSize: borderSize, dotSize: dotSize, spacing: buttonSpacing);
      radioButton.addTarget(self, action: #selector(radioButtonDidTap(sender:)), for: .touchUpInside);
      radioButton.backgroundColor = .clear;
      radioButton.translatesAutoresizingMaskIntoConstraints = false;
      radioButton.tag = i;

      radioButton.titleLabel.text = title;
      radioButton.titleLabel.textColor = titleColor;
      radioButton.titleLabel.font = titleFont;
      
      radioButton.dot.backgroundColor = dotColor;
      radioButton.border.layer.borderColor = borderColor.cgColor;
      radioButton.border.layer.borderWidth = borderWidth;
      
      radioButtons.append(radioButton);
      addSubview(radioButton);
      
      radioButton.topAnchor.constraint(equalTo: topAnchor).isActive = true;
      radioButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
      
      if i != 0 {
        radioButton.isSelected = false;
        let previousRadioButton = self.radioButtons[i-1];
        radioButton.leftAnchor.constraint(equalTo: previousRadioButton.rightAnchor, constant: titleSpacing).isActive = true;

        if (i == titles.count-1) {
          radioButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
        }
      } else {
        radioButton.isSelected = true;
        currentSelectedButton = radioButton;
        radioButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame);
  }
  
  required public init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func radioButtonDidTap(sender: CustomRadioButton) {
    guard currentSelectedButton != sender else { return }
    self.radioButtons.forEach { (button) in
      button.isSelected = false;
    }
    
    sender.isSelected = !sender.isSelected;
    currentSelectedButton = sender;
    self.delegate?.didSelectedButton(sender, value: self.values[sender.tag]);
  }
}
