//
//  Appearance+String.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/9/15.
//

import Foundation

fileprivate var attributedStringPickerKey = "AttributedStringPicker"

extension NSAttributedString {
    public var themePicker: ThemeAttributedStringPicker? {
        get {
            objc_getAssociatedObject(self, &attributedStringPickerKey) as? ThemeAttributedStringPicker
        }
        set {
            objc_setAssociatedObject(self, &attributedStringPickerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public extension Appearance
{
    class func dynamicString(_ strings: [NSAttributedString], _ defaultValue: NSAttributedString) -> NSAttributedString {
        return getDynamicString(strings.description, ThemeAttributedStringPicker.pickerWithAttributedStrings(strings), defaultValue)
    }
    
}

private func getDynamicString(
    _ name: String,
    _ themePicker: ThemeAttributedStringPicker,
    _ defaultValue: NSAttributedString
) -> NSAttributedString {
    return makeDynamicString(name, themePicker, defaultValue)
//    guard let picker = Appearance.attributedStringPickers[name], let string = picker.value() as? NSAttributedString else {
//        return makeDynamicString(name, themePicker, defaultValue)
//    }
//    string.themePicker = picker
//    return string
}

private func makeDynamicString(
    _ name: String,
    _ themePicker: ThemeAttributedStringPicker,
    _ defaultValue: NSAttributedString
) -> NSAttributedString {
    let string: NSAttributedString = themePicker.value() as? NSAttributedString ?? defaultValue
//    Appearance.attributedStringPickers[name] = themePicker
    string.themePicker = themePicker
    return string
}
