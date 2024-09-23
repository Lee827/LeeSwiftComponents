//
//  UINavigationController.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 23/09/2024.
//

public extension UITapGestureRecognizer {
  func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
    guard let attributedText = label.attributedText else { return false }
    
    // 建立 NSTextStorage, NSLayoutManager 和 NSTextContainer 來計算點擊位置
    let textStorage = NSTextStorage(attributedString: attributedText)
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: label.bounds.size)
    textContainer.lineFragmentPadding = 0
    textContainer.maximumNumberOfLines = label.numberOfLines
    textContainer.lineBreakMode = label.lineBreakMode
    
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)
    
    // 取得點擊的位置
    let locationOfTouchInLabel = self.location(in: label)
    let textBoundingBox = layoutManager.usedRect(for: textContainer)
    let alignmentOffset = (label.bounds.size.height - textBoundingBox.size.height) / 2
    let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x, y: locationOfTouchInLabel.y - alignmentOffset)
    
    // 確定點擊的字元索引
    let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    
    // 判斷點擊的索引是否在目標範圍內
    return NSLocationInRange(indexOfCharacter, targetRange)
  }
}
