//
//  ThemeAttributedStringPicker.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/9/15.
//

import Foundation

@objc public final class ThemeAttributedStringPicker: ThemePicker {
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> NSAttributedString?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(_ attributedStrings: [NSAttributedString]...) {
        self.init(v: { ThemeManager.element(for: attributedStrings) })
    }
    
    public required convenience init(arrayLiteral elements: NSAttributedString...) {
        self.init(v: {
            guard let string = ThemeManager.element(for: elements) else { return nil }
            return NSAttributedString(attributedString: string)
        })
    }
    
}

@objc public extension ThemeAttributedStringPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> NSAttributedString?) -> ThemeAttributedStringPicker {
        return ThemeAttributedStringPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithAttributedStrings(_ attributedStrings: [NSAttributedString]) -> ThemeAttributedStringPicker {
        return ThemeAttributedStringPicker(v: {
            guard let string = ThemeManager.element(for: attributedStrings) else { return nil }
            return NSAttributedString(attributedString: string)
        })
    }
    
}

extension ThemeAttributedStringPicker: ExpressibleByArrayLiteral {}
