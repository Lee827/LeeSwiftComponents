//
//  GlobalFunctions.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

import CommonCrypto

public func printLog<T>( _ object: @autoclosure() -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
  #if DEBUG
    let value = object();
    let stringRepresentation: String;
    
    if let value = value as? CustomDebugStringConvertible {
      stringRepresentation = value.debugDescription;
    } else if let value = value as? CustomStringConvertible {
      stringRepresentation = value.description;
    } else {
      print("printLog only works for values that conform to CustomDebugStringConvertible or CustomStringConvertible");
      stringRepresentation = "Unknown";
    }
    
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file";
    let queue = Thread.isMainThread ? "UI" : "BG";
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS";
    let timestamp = dateFormatter.string(from: Date());
    
    print("✅ \(timestamp) {\(queue)} \(fileURL)[\(line)] \(function):\nPrintLog - " + stringRepresentation);
  #endif
}

public var DateWithGMTTimeZone: Date {
  return DateWithTimeZone(timeZone: TimeZone(abbreviation: "GMT"));
}

public func DateWithTimeZone(timeZone: TimeZone?)-> Date {
  let now = Date();
  var dateComponents = DateComponents();
  let calendar = NSCalendar.current;
  dateComponents.year = calendar.component(Calendar.Component.year, from: now);
  dateComponents.month = calendar.component(Calendar.Component.month, from: now);
  dateComponents.day = calendar.component(Calendar.Component.day, from: now);
  dateComponents.hour = calendar.component(Calendar.Component.hour, from: now);
  dateComponents.minute = calendar.component(Calendar.Component.minute, from: now);
  dateComponents.second = calendar.component(Calendar.Component.second, from: now);
  dateComponents.timeZone = timeZone;
  
  guard let calendarDate = calendar.date(from: dateComponents) else {
    fatalError("can't get converted date from calendar");
  }
  
  return calendarDate;
}

public func getQueryStringParameter(url: String?, param: String) -> String? {
  if let url = url, let urlComponents = URLComponents(string: url), let queryItems = (urlComponents.queryItems) {
    return queryItems.first(where: { $0.name == param })?.value;
  }
  return nil;
}

public func getTextHeight(text:String, font:UIFont, width:CGFloat) -> CGFloat{
  let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude));
  label.numberOfLines = 0;
  label.lineBreakMode = NSLineBreakMode.byWordWrapping;
  label.font = font;
  label.text = text;
  label.sizeToFit();
  return label.frame.height;
}

public func priceFormatter(_ value: String?, minDigits: Int? = 0, maxDigits: Int? = 1, symbol: String? = "$", currencyCode: String? = "HKD") -> String {
  guard value != nil else { return "\(String(symbol ?? "$"))0"; }
  let doubleValue = Double(value!) ?? 0.0;
  let formatter = NumberFormatter();
  formatter.currencyCode = currencyCode;
  formatter.currencySymbol = symbol;
  formatter.minimumFractionDigits = minDigits ?? 0;
  formatter.maximumFractionDigits = maxDigits ?? 1;
  formatter.numberStyle = .currencyAccounting;
  return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(String(symbol ?? "$"))\(doubleValue)";
}

public func priceFormatter(_ value: Double?, minDigits: Int? = 0, maxDigits: Int? = 1, symbol: String? = "$", currencyCode: String? = "HKD") -> String {
  guard let _value = value else { return "\(String(symbol ?? "$"))0"; }
  let formatter = NumberFormatter();
  formatter.currencyCode = currencyCode;
  formatter.currencySymbol = symbol;
  formatter.minimumFractionDigits = minDigits ?? 0;
  formatter.maximumFractionDigits = maxDigits ?? 1;
  formatter.numberStyle = .currencyAccounting;
  return formatter.string(from: NSNumber(value: _value)) ?? "\(String(symbol ?? "$"))\(_value)";
}

public func generateKey(value: String) -> Data {
  let keyData = value.data(using: .utf8)!
  var keyBytes = [UInt8](repeating: 0, count: kCCKeySizeAES128)
  let digest = keyData.withUnsafeBytes {
    var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    CC_SHA256($0.baseAddress, CC_LONG(keyData.count), &hash)
    return hash
  }
  keyBytes = Array(digest.prefix(kCCKeySizeAES128))
  return Data(keyBytes)
}

public func generateRandomIV() -> Data {
  // Create an empty Data object with size of AES block size (16 bytes)
  var iv = Data(count: kCCBlockSizeAES128);
  
  // Use withUnsafeMutableBytes to access the raw memory safely
  let result = iv.withUnsafeMutableBytes { ivBytes in
    guard let ivBaseAddress = ivBytes.baseAddress else {
      return errSecAllocate // Memory allocation failure
    }
    // Fill the iv with random bytes
    return SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBaseAddress);
  }
  
  // Check if the random bytes generation succeeded
  if result != errSecSuccess {
    fatalError("Unable to generate random IV. Error code: \(result)");
  }
  
  return iv;
}

// Encrypt data
public func aesEncrypt(data: Data, key: Data, iv: Data) -> Data? {
  guard key.count == kCCKeySizeAES128 else {
    printLog("Invalid key size")
    return nil
  }
  
  let bufferSize = data.count + kCCBlockSizeAES128
  var buffer = Data(count: bufferSize)
  
  var numBytesEncrypted: size_t = 0
  
  let status = buffer.withUnsafeMutableBytes { bufferPtr in
    data.withUnsafeBytes { dataPtr in
      key.withUnsafeBytes { keyPtr in
        iv.withUnsafeBytes { ivPtr in
          CCCrypt(
            CCOperation(kCCEncrypt),
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding),
            keyPtr.baseAddress, key.count,
            ivPtr.baseAddress,
            dataPtr.baseAddress, data.count,
            bufferPtr.baseAddress, bufferSize,
            &numBytesEncrypted
          )
        }
      }
    }
  }
  
  guard status == kCCSuccess else {
    printLog("Encryption failed with status: \(status)")
    return nil
  }
  
  return buffer.prefix(numBytesEncrypted)
}

// Decrypt data
public func aesDecrypt(data: Data, key: Data, iv: Data) -> Data? {
  guard key.count == kCCKeySizeAES128 else {
    printLog("Invalid key size")
    return nil
  }
  
  let bufferSize = data.count + kCCBlockSizeAES128
  var buffer = Data(count: bufferSize)
  
  var numBytesDecrypted: size_t = 0
  
  let status = buffer.withUnsafeMutableBytes { bufferPtr in
    data.withUnsafeBytes { dataPtr in
      key.withUnsafeBytes { keyPtr in
        iv.withUnsafeBytes { ivPtr in
          CCCrypt(
            CCOperation(kCCDecrypt),
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding),
            keyPtr.baseAddress, key.count,
            ivPtr.baseAddress,
            dataPtr.baseAddress, data.count,
            bufferPtr.baseAddress, bufferSize,
            &numBytesDecrypted
          )
        }
      }
    }
  }
  
  guard status == kCCSuccess else {
    printLog("Decryption failed with status: \(status)")
    return nil
  }
  
  return buffer.prefix(numBytesDecrypted)
}
