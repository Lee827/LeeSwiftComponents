//
//  Data.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension Data {
  // APNs Token converter
  var hexString: String {
    return map { String(format: "%02.2hhx", arguments: [$0]) }.joined();
  }
}
