//
//  ThemeCGFloatPicker.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/15.
//

import Foundation

@objc public final class ThemeCGFloatPicker: ThemePicker{
    
    public convenience init(keyPath: String) {
        self.init(v: { CGFloat(ThemeManager.number(for: keyPath)?.doubleValue ?? 0) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> CGFloat?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(floats: CGFloat...) {
        self.init(v: { ThemeManager.element(for: floats) })
    }
    
    public required convenience init(arrayLiteral elements: CGFloat...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
}

public extension ThemeCGFloatPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> CGFloat?) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(keyPath: keyPath, map: map)
    }
    
}

@objc public extension ThemeCGFloatPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(keyPath: keyPath)
    }
    
    class func pickerWithFloats(_ floats: [CGFloat]) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(v: { ThemeManager.element(for: floats) })
    }
    
}

extension ThemeCGFloatPicker: ExpressibleByArrayLiteral {}
extension ThemeCGFloatPicker: ExpressibleByStringLiteral {}
