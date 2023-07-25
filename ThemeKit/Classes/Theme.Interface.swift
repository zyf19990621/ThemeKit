//
//  Theme.Interface.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/30.
//

import Foundation

// MARK: Theme + Themes
public extension Theme {
    
    @objc enum Themes: Int {
        case light = 0
        case dark = 1
        
        @available(iOS 13.0, *)
        public var userInterfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
    }
    
    /// 用于判断当前应用主题是“跟随系统(false)”还是“深色、浅色(true)”
    @objc static var userDefined: Bool {
        get {
            defaults.bool(forKey: themeCustomKey)
        }
        set {
            defaults.set(newValue, forKey: themeCustomKey)
        }
    }
    
    /// 返回当前应用主题
    @objc static var current: Themes { Themes(rawValue: ThemeManager.currentThemeIndex) ?? .light }
    
    // MARK: 主题切换API
    static var enableDarkMode: Bool = false
    
    static func switchTheme(to theme: Themes? = nil) {
        let index: Int = theme?.rawValue ?? (current.rawValue + 1) % 2
        ThemeManager.setTheme(index: index)
        _updateAppearance()
        saveTheme()
    }
    
    static func switchToDark(_ isToDark: Bool = true) {
        switchTheme(to: isToDark ? .dark : .light)
    }
    
    /// 保存当前主题index，建议在applicationWillTerminate()中调用
    static func saveTheme() {
        defaults.set(current.rawValue, forKey: lastThemeIndexKey)
    }
    
    static func launching(enabled: Bool) {
        enableDarkMode = enabled
        if #available(iOS 13.0, *) {
            UIWindow.swizzlingForInterface
        }
        if enabled { _swizzling() }
        _initialTheme()
    }
}

// MARK: Theme + Appearance
public extension Theme {
    static func navigationBarAppearance() {
        let navigationBar = UINavigationBar.appearance()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.common_bg2_color
            appearance.shadowImage = UIImage(color: UIColor.clear)
            appearance.shadowColor = .clear
            appearance.setTitleTextAttributes(attributesPicker: Appearance.Attributes.navigate_title)
            
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.setTitleTextAttributes(attributesPicker: Appearance.Attributes.navigate_right_item)
            buttonAppearance.highlighted.setTitleTextAttributes(attributesPicker: Appearance.Attributes.navigate_right_item_highlighted)
            appearance.buttonAppearance = buttonAppearance
            appearance.doneButtonAppearance = buttonAppearance
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.setDynamicStandardAppearance([appearance, appearance])
            navigationBar.setDynamicScrollEdgeAppearance([appearance, appearance])
            navigationBar.setDynamicCompactAppearance([appearance, appearance])
            if #available(iOS 15, *) {
                navigationBar.compactScrollEdgeAppearance = appearance
                navigationBar.setDynamicCompactScrollEdgeAppearance([appearance, appearance])
            }
        } else {
            let navigationBarItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            navigationBarItem.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.common_level1_color
            ], for: .normal)
            navigationBarItem.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.common_level3_color
            ], for: .highlighted)
            
            navigationBar.isTranslucent = false
            navigationBar.tintColor = UIColor.common_level1_color
            navigationBar.barTintColor = UIColor.common_bg2_color
            navigationBar.shadowImage = UIImage(color: UIColor.common_line2_color)
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.common_level1_color
            ]
        }
    }
    
    static func textFieldAppearance() {
        let textField = UITextField.appearance()
        textField.tintColor = .common_orange1_color
        textField.textColor = .common_level1_color
        textField.setKeyboardAppearance(picker: [.light, .dark])
    }
    
    static func textViewAppearance() {
        let textView = UITextView.appearance()
        textView.tintColor = .common_orange1_color
        textView.textColor = .common_level1_color
        textView.backgroundColor = .common_bg2_color
        textView.setKeyboardAppearance(picker: [.light, .dark])
    }
}

// MARK: Theme + Configuration
private extension Theme {
    
    static func _swizzling() {
        UIView.swizzlingForView
        UILabel.swizzlingForLabel
        UIImageView.swizzlingForImageView
        UIButton.swizzlingForButton
        UITableView.swizzlingForTableView
        CALayer.swizzlingForLayer
        UITextField.swizzlingForTextField
        UITextView.swizzlingForTextView
        UISearchBar.swizzlingForSearchBar
        UINavigationBar.swizzlingForNavigationBar
        UITabBar.swizzlingForTabBar
        UIBarItem.swizzlingForBarItem
        UITabBarItem.swizzlingForTabBarItem
        UISwitch.swizzlingForSwitch
        UISlider.swizzlingForSlider
        UIProgressView.swizzlingForProgress
        UIPageControl.swizzlingForPageControl
        UIActivityIndicatorView.swizzlingForIndicator
        if #available(iOS 13.0, *) {
            UIWindow.swizzlingForAppearance
            UIBarAppearance.swizzlingForAppearance
        }
    }
    
    /// 初始化应用主题，若之前未存储则切换至.light浅色模式
    static func _initialTheme() {
        let index: Int
        if !enableDarkMode {
            index = 0
        } else if #available(iOS 13.0, *), !Theme.userDefined {
            let theme: Themes = UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
            index = theme.rawValue
        } else {
            index = defaults.integer(forKey: lastThemeIndexKey)
            guard index != current.rawValue else {
                ThemeManager.currentThemeIndex = index
                return
            }
        }
        ThemeManager.setTheme(index: index)
        saveTheme()
    }
    
    static func _updateAppearance() {
        textFieldAppearance()
        textViewAppearance()
        navigationBarAppearance()
    }
}

private let lastThemeIndexKey = "LastThemeIndex"
private let themeCustomKey = "ThemeIsCustomized"
private let defaults = UserDefaults.standard
