//
//  ThemeColorPicker.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/29.
//

import Foundation

@objc public final class ThemeColorPicker: ThemePicker {
    
    var colorValues: [String]?
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.color(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIColor?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(colors: String...) {
        self.init(v: { ThemeManager.colorElement(for: colors) })
        colorValues = colors
    }
    
    public convenience init(colors: UIColor...) {
        self.init(v: { ThemeManager.element(for: colors) })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.colorElement(for: elements) })
        colorValues = elements
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

@objc public extension ThemeColorPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIColor?) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithColors(_ colors: [String]) -> ThemeColorPicker {
        let themePicker = ThemeColorPicker(v: { ThemeManager.colorElement(for: colors) })
        themePicker.colorValues = colors
        return themePicker
    }
    
    class func pickerWithUIColors(_ colors: [UIColor]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { ThemeManager.element(for: colors) })
    }
    
}

extension ThemeColorPicker: ExpressibleByArrayLiteral {}
extension ThemeColorPicker: ExpressibleByStringLiteral {}
