//
//  Appearance+Attributes.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/4.
//

import Foundation

public extension Appearance {
    enum Attributes {}
    
//    @objc class func attributesPicker(_ name: String, defaultValue: ThemeStringAttributesPicker? = nil) -> ThemeStringAttributesPicker? {
//        guard let picker = Appearance.attributesPickers[name] else {
//            print("ThemeKit WARNING: Can't find attributes called '\(name)'")
//            return defaultValue
//        }
//        return picker
//    }
}

public extension Appearance.Attributes {
    static var navigate_title: ThemeStringAttributesPicker {
        getDynamicAttributes("navigate_title",
                             [[
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#333333")
                             ],
                              [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFFE5")
                              ]])
    }
    
    static var navigate_right_item: ThemeStringAttributesPicker {
        getDynamicAttributes("navigate_right_item",
                             [[
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#333333")
                             ],
                              [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFFE5")
                              ]])
    }
    
    static var navigate_right_item_highlighted: ThemeStringAttributesPicker {
        getDynamicAttributes("navigate_right_item_highlighted",
                             [[
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#999999")
                             ],
                              [
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFF7F")
                              ]])
    }
    
    static var navigate_right_item_disabled: ThemeStringAttributesPicker {
        getDynamicAttributes("navigate_right_item_disabled",
                             [[
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#BBBBBB")
                             ],
                              [
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFF3F")
                              ]])
    }
    
    static var navigate_right_item_orange: ThemeStringAttributesPicker {
        getDynamicAttributes("navigate_right_item_orange",
                             [[
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FD7443")
                             ],
                              [
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#D15731")
                              ]])
    }
    
    static var text_field_placeholder: ThemeStringAttributesPicker {
        getDynamicAttributes("text_field_placeholder",
                             [[
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#3C3C434C")
                             ],
                              [
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#EBEBF54C")
                              ]])
    }
    
    static var tabbar_item_normal: ThemeStringAttributesPicker {
        getDynamicAttributes("tabbar_item_normal",
                             [[
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#999999")
                             ],
                              [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFF7F")
                              ]])
    }
    
    static var tabbar_item_selected: ThemeStringAttributesPicker {
        getDynamicAttributes("tabbar_item_selected",
                             [[
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#333333")
                             ],
                              [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                NSAttributedString.Key.foregroundColor: UIColor(rgba: "#FFFFFFE5")
                              ]])
    }
}

private func getDynamicAttributes(
    _ name: String,
    _ themePicker: ThemeStringAttributesPicker
) -> ThemeStringAttributesPicker {
    return themePicker
//    guard let picker = Appearance.attributesPickers[name] else {
//        Appearance.attributesPickers[name] = themePicker
//        return themePicker
//    }
//    return picker
}
