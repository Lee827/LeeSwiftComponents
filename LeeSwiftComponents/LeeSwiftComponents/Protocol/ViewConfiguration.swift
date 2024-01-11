//
//  ViewConfiguration.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

public protocol ViewConfiguration: AnyObject {
  func configureViews()
  func buildViewHierarchy()
  func setupConstraints()
  func setupViewConfiguration()
}

public extension ViewConfiguration {
  func setupViewConfiguration() {
    configureViews();
    buildViewHierarchy();
    setupConstraints();
  }
}
