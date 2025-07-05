//
//  AttributedStringTransformer.swift
//  QuadraSD
//
//  Created by Tatyana Balashenko on 19/05/2025.
//

import Foundation

@objc(AttributedStringTransformer)
final class AttributedStringTransformer: ValueTransformer {
  override class func transformedValueClass() -> AnyClass {
    NSAttributedString.self
  }

  override class func allowsReverseTransformation() -> Bool {
    true
  }

  override func transformedValue(_ value: Any?) -> Any? {
    guard let attrString = value as? NSAttributedString else { return nil }
    return try? NSKeyedArchiver.archivedData(
      withRootObject: attrString,
      requiringSecureCoding: false
    )
  }

  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard
      let data = value as? Data,
      let obj = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
    else { return nil }
    return obj
  }
}
