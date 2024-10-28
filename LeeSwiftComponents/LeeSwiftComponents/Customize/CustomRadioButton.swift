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

  var border: UIView {
    let v = UIView();
    v.backgroundColor = .clear;
    v.layer.borderColor = UIColor.gray.cgColor;
    v.layer.borderWidth = 1;
    v.isUserInteractionEnabled = false;
    v.translatesAutoresizingMaskIntoConstraints = false;
    return v;
  }
  
  var dot: UIView {
    let v = UIView();
    v.backgroundColor = .black;
    v.isUserInteractionEnabled = false;
    v.translatesAutoresizingMaskIntoConstraints = false;
    return v;
  }
  
  var titleLabel: UILabel {
    let l = UILabel();
    l.font = UIFont.systemFont(ofSize: 15, weight: .regular);
    l.textColor = .gray;
    l.translatesAutoresizingMaskIntoConstraints = false;
    return l;
  }
  
  required public init(borderSize: CGFloat = 16, dotSize: CGFloat = 12, spacing: CGFloat = 8) {
    self.borderSize = borderSize;
    self.dotSize = dotSize;
    self.spacing = spacing;
    super.init(frame: CGRect.zero);
    
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
