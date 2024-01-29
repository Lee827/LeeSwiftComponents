//
//  OTPStackView.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 29/01/2024.
//

open class OTPStackView: UIStackView {
  
  //Customise the OTPField here
  public var numberOfFields: Int = 6
  public var textFieldsCollection: [OTPTextField] = []
  weak public var delegate: OTPDelegate?
  public var showsWarningColor: Bool = false
  public var textFieldSpacing: CGFloat = 12
  public var textFieldRadius: CGFloat = 8
  public var textFieldBorderWidth: CGFloat = 1
  public var textFieldFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
  
  //Colors
  public var stackViewBackgroundColor: UIColor = .clear
  public var inactiveFieldBorderColor: UIColor = .clear
  public var textBackgroundColor: UIColor = .white
  public var activeFieldBorderColor: UIColor = .gray
  public var textFieldColor: UIColor = .black
  
  var remainingStrStack: [String] = []
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
    addOTPFields()
  }
  
  //Customisation and setting stackView
  private final func setupStackView() {
    self.backgroundColor = stackViewBackgroundColor
    self.isUserInteractionEnabled = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.contentMode = .center
    self.distribution = .fillEqually
    self.spacing = textFieldSpacing
  }
  
  //Adding each OTPfield to stack view
  private final func addOTPFields() {
    for index in 0..<numberOfFields {
      let field = OTPTextField()
      setupTextField(field)
      textFieldsCollection.append(field)
      //Adding a marker to previous field
      index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
      //Adding a marker to next field for the field at index-1
      index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
    }
    textFieldsCollection[0].becomeFirstResponder()
  }
  
  //Customisation and setting OTPTextFields
  private final func setupTextField(_ textField: OTPTextField) {
    textField.delegate = self
    textField.translatesAutoresizingMaskIntoConstraints = false
    self.addArrangedSubview(textField)
    textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    textField.backgroundColor = textBackgroundColor
    textField.textAlignment = .center
    textField.adjustsFontSizeToFitWidth = true
    textField.font = textFieldFont
    textField.textColor = textFieldColor
    textField.layer.cornerRadius = textFieldRadius
    textField.layer.borderWidth = textFieldBorderWidth
    textField.layer.borderColor = inactiveFieldBorderColor.cgColor
    textField.keyboardType = .numberPad
    textField.autocorrectionType = .yes
    textField.textContentType = .oneTimeCode
  }
  
  //checks if all the OTPfields are filled
  private final func checkForValidity() {
    for fields in textFieldsCollection {
      if (fields.text == ""){
        delegate?.didChangeValidity(isValid: false)
        return
      }
    }
    delegate?.didChangeValidity(isValid: true)
  }
  
  //gives the OTP text
  final func getOTP() -> String {
    var OTP = ""
    for textField in textFieldsCollection {
      OTP += textField.text ?? ""
    }
    return OTP
  }
  
  //set isWarningColor true for using it as a warning color
  final func setAllFieldColor(isWarningColor: Bool = false, color: UIColor) {
    for textField in textFieldsCollection {
      textField.layer.borderColor = color.cgColor
    }
    showsWarningColor = isWarningColor
  }
  
  //autofill textfield starting from first
  private final func autoFillTextField(with string: String) {
    remainingStrStack = string.reversed().compactMap{String($0)}
    for textField in textFieldsCollection {
      if let charToAdd = remainingStrStack.popLast() {
        textField.text = String(charToAdd)
      } else {
        break
      }
    }
    checkForValidity()
    remainingStrStack = []
  }
  
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if showsWarningColor {
      setAllFieldColor(color: inactiveFieldBorderColor)
      showsWarningColor = false
    }
    textField.layer.borderColor = activeFieldBorderColor.cgColor
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    checkForValidity()
    textField.layer.borderColor = inactiveFieldBorderColor.cgColor
  }
  
  //switches between OTPTextfields
  func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                 replacementString string: String) -> Bool {
    guard let textField = textField as? OTPTextField else { return true }
    if string.count > 1 {
      textField.resignFirstResponder()
      autoFillTextField(with: string)
      return false
    } else if (string.count == 0) {
      if (range.length == 0) {
        return false
      }
      return true
    } else {
      if (range.length == 0) {
        if textField.nextTextField == nil {
          textField.text? = string
          textField.resignFirstResponder()
        } else {
          textField.text? = string
          textField.nextTextField?.becomeFirstResponder()
        }
        return false
      }
      return true
    }
  }
}

public protocol OTPDelegate: class {
  //always triggers when the OTP field is valid
  func didChangeValidity(isValid: Bool)
}

open class OTPTextField: UITextField {
  weak var previousTextField: OTPTextField?
  weak var nextTextField: OTPTextField?
  override public func deleteBackward() {
    if (text == "") {
      previousTextField?.text = "";
    } else {
      text = "";
    }
    previousTextField?.becomeFirstResponder()
  }
}
