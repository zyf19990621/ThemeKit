//
//  Theme+Window.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2023/1/9.
//

import UIKit

@available(iOS 13.0, *)
extension UIWindow {
    static let swizzlingForInterface: Void = {
        DRuntime.methodSwizzling(cls: UIWindow.self, #selector(UIWindow.init(frame:)), #selector(theme_init(frame:)))
    }()
    
    static let swizzlingForAppearance: Void = {
        DRuntime.methodSwizzling(cls: UIWindow.self, #selector(UIWindow.traitCollectionDidChange(_:)), #selector(theme_traitCollectionDidChange(previousTraitCollection:)))
    }()
}

@available(iOS 13.0, *)
fileprivate extension UIWindow {
    @objc func theme_init(frame: CGRect) -> UIWindow {
        let window = self.theme_init(frame: frame)
        if !Theme.enableDarkMode {
            window.overrideUserInterfaceStyle = .light
        } else {
            setupThemeNotification()
            window.overrideUserInterfaceStyle = Theme.userDefined ? Theme.current.userInterfaceStyle : .unspecified
        }
        return window
    }
    
    @objc func theme_traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        self.theme_traitCollectionDidChange(previousTraitCollection: previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) && Theme.enableDarkMode && !Theme.userDefined else { return }
        Theme.switchToDark(traitCollection.userInterfaceStyle == .dark)
    }
}
