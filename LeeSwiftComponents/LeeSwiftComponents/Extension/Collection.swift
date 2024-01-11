//
//  Collection.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public extension Collection {
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index]: nil;
  }
}
