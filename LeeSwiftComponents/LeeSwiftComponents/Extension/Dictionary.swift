//
//  Dictionary.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension Dictionary where Key == String {
  subscript(caseInsensitive key: Key) -> Value? {
    get {
      guard let exists = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) else { return nil; }
      return self[exists];
    }
    set {
      if let exists = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) {
        self[exists] = newValue;
      } else {
        self[key] = newValue;
      }
    }
  }
}

