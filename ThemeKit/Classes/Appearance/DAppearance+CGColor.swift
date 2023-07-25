//
//  Appearance+CGColor.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/6.
//

import Foundation

fileprivate var cgColorPickerKey = "CGColorPicker"

extension CGColor
{
    var themePicker: ThemeCGColorPicker? {
        get {
            objc_getAssociatedObject(self, &cgColorPickerKey) as? ThemeCGColorPicker
        }
        set {
            objc_setAssociatedObject(self, &cgColorPickerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public extension Appearance
{
    @objc class func cgColor(_ name: String, defaultValue: CGColor? = nil) -> CGColor? {
//        if let picker = Appearance.cgColorPickers[name], let color = maybeCast(picker.value()) {
//            color.themePicker = picker
//            return color
//        }
        let picker = ThemeCGColorPicker(keyPath: name)
        guard let color = maybeCast(picker.value()) else {
            print("ThemeKit WARNING: Can't find color called '\(name)'")
            return defaultValue
        }
//        Appearance.cgColorPickers[name] = picker
        color.themePicker = picker
        return color
    }
}

func getDynamicColor(
    _ name: String,
    _ themePicker: ThemeCGColorPicker,
    _ defaultValue: CGColor
) -> CGColor {
    return makeDynamicColor(name, themePicker, defaultValue)
//    guard let picker = Appearance.cgColorPickers[name], let color = maybeCast(picker.value()) else {
//        return makeDynamicColor(name, themePicker, defaultValue)
//    }
//    color.themePicker = picker
//    return color
}

func makeDynamicColor(
    _ name: String,
    _ themePicker: ThemeCGColorPicker,
    _ defaultValue: CGColor
) -> CGColor {
    let color: CGColor = maybeCast(themePicker.value()) ?? defaultValue
//    Appearance.cgColorPickers[name] = themePicker
    color.themePicker = themePicker
    return color
}

private func maybeCast<T>(_ value: T) -> CGColor? {
    guard CFGetTypeID(value as CFTypeRef) == CGColor.typeID else {
        return nil
    }
    return (value as! CGColor)
}
