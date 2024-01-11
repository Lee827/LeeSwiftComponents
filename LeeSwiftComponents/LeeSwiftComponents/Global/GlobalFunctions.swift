//
//  GlobalFunctions.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

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
    
    print("✅ \(timestamp) {\(queue)} \(fileURL)[\(line)] \(function):\n" + stringRepresentation);
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

public func priceFormatter(_ value: String?, symbol: String? = "$") -> String {
  guard value != nil else { return "$0"; }
  let doubleValue = Double(value!) ?? 0.0;
  let formatter = NumberFormatter();
  formatter.currencyCode = "HKD";
  formatter.currencySymbol = symbol;
  formatter.minimumFractionDigits = 0;
  formatter.maximumFractionDigits = 1;
  formatter.numberStyle = .currencyAccounting;
  return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(String(symbol ?? "$"))\(doubleValue)";
}
