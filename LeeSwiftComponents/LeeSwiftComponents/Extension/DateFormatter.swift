//
//  DateFormatter.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension DateFormatter {
  func dateFormat(string: String, from: String? = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", changeTo: String? = "yyyy/MM/dd", locale: Locale? = Locale(identifier: "en_US_POSIX"), timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = from;
    dateFormatter.timeZone = timeZone;
    dateFormatter.locale =  locale;
    if let formateDate = dateFormatter.date(from: string) {
      dateFormatter.dateFormat = changeTo;
      return dateFormatter.string(from: formateDate);
    }
    return string;
  }
  
  func distanceNow(string: String, from: String? = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", locale: Locale? = Locale(identifier: "en_US_POSIX"), timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> Int? {
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = from;
    dateFormatter.timeZone = timeZone;
    dateFormatter.locale =  locale;
    
    if let formateDate = dateFormatter.date(from: string) {
      let now = Date();
      let distance = now.distance(to: formateDate);

      return Int(distance);
    }
    return nil;
  }
}
