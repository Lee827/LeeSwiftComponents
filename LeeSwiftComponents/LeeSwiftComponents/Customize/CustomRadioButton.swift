//
//  CustomRadioButton.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 29/01/2024.
//

open class CustomRadioButton: UIControl {
  var borderSize: CGFloat = 16;
  var dotSize: CGFloat = 12;
  var spacing: CGFloat = 8;

  public let border = UIView();
  public let dot = UIView();
  public let titleLabel = UILabel();
  
  required public init(borderSize: CGFloat = 16, dotSize: CGFloat = 12, spacing: CGFloat = 8) {
    self.borderSize = borderSize;
    self.dotSize = dotSize;
    self.spacing = spacing;
    super.init(frame: CGRect.zero);
    
    border.backgroundColor = .clear;
    border.layer.borderColor = UIColor.gray.cgColor;
    border.layer.borderWidth = 1;
    border.isUserInteractionEnabled = false;
    border.translatesAutoresizingMaskIntoConstraints = false;
    
    dot.backgroundColor = .black;
    dot.isUserInteractionEnabled = false;
    dot.translatesAutoresizingMaskIntoConstraints = false;
    
    titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular);
    titleLabel.textColor = .gray;
    titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    addSubview(border);
    border.addSubview(dot);
    addSubview(titleLabel);
    
    border.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
    border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
    border.widthAnchor.constraint(equalToConstant: borderSize).isActive = true;
    border.heightAnchor.constraint(equalToConstant: borderSize).isActive = true;

    border.layer.cornerRadius = borderSize/2;
    
    dot.centerYAnchor.constraint(equalTo: border.centerYAnchor).isActive = true;
    dot.centerXAnchor.constraint(equalTo: border.centerXAnchor).isActive = true;
    dot.widthAnchor.constraint(equalToConstant: dotSize).isActive = true;
    dot.heightAnchor.constraint(equalToConstant: dotSize).isActive = true;
    
    dot.layer.cornerRadius = dotSize/2;
    
    titleLabel.leftAnchor.constraint(equalTo: border.rightAnchor, constant: spacing).isActive = true;
    titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
    titleLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true;
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame);
  }
  
  required public init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  public override var isSelected: Bool {
    didSet{
      dot.isHidden = !isSelected;
    }
  }
}
