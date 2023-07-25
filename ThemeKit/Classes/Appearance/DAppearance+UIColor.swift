//
//  Appearance+UIColor.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/30.
//

import UIKit

fileprivate var colorPickerKey = "ColorPicker"

extension UIColor
{
    public var themePicker: ThemeColorPicker? {
        get {
            objc_getAssociatedObject(self, &colorPickerKey) as? ThemeColorPicker
        }
        set {
            objc_setAssociatedObject(self, &colorPickerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var lightValue: UIColor {
        guard let themePicker = themePicker, let rgba = themePicker.colorValues?.first else { return self }
        guard let color = try? UIColor(rgba_throws: rgba) else {
            print("ThemeKit WARNING: Not convert rgba \(rgba) in array: \(themePicker.colorValues!)[0]")
            return self
        }
        return color
    }
    
    public var darkValue: UIColor {
        guard let themePicker = themePicker, let rgba = themePicker.colorValues?.last else { return self }
        guard let color = try? UIColor(rgba_throws: rgba) else {
            print("ThemeKit WARNING: Not convert rgba \(rgba) in array: \(themePicker.colorValues!)[1]")
            return self
        }
        return color
    }
}

public extension Appearance
{    
    @objc class func color(_ name: String, defaultValue: UIColor? = nil) -> UIColor? {
//        if let picker = Appearance.colorPickers[name], let color = picker.value() as? UIColor {
//            color.themePicker = picker
//            return color
//        }
        let picker = ThemeColorPicker(keyPath: name)
        guard let color = picker.value() as? UIColor else {
            print("ThemeKit WARNING: Can't find color called '\(name)'")
            return defaultValue
        }
//        Appearance.colorPickers[name] = picker
        color.themePicker = picker
        return color
    }
}

func getDynamicColor(
    _ name: String,
    _ themePicker: ThemeColorPicker,
    _ defaultValue: UIColor
) -> UIColor {
    return makeDynamicColor(name, themePicker, defaultValue)
//    guard let picker = Appearance.colorPickers[name], let color = picker.value() as? UIColor else {
//        return makeDynamicColor(name, themePicker, defaultValue)
//    }
//    color.themePicker = picker
//    color.themePicker?.colorValues = picker.colorValues
//    return color
}

func makeDynamicColor(
    _ name: String,
    _ themePicker: ThemeColorPicker,
    _ defaultValue: UIColor
) -> UIColor {
    let color: UIColor = themePicker.value() as? UIColor ?? defaultValue
//    Appearance.colorPickers[name] = themePicker
    color.themePicker = themePicker
    color.themePicker?.colorValues = themePicker.colorValues
    return color
}
