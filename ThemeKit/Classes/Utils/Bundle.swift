//
//  Bundle.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/29.
//

import Foundation

public class Theme: NSObject {}

extension Theme {
    
    public static var bundle:Bundle {
        get {
            guard let bundleURL = Bundle(for: Theme.self).url(forResource: "Themes", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) else {
                return Bundle(for: Theme.self)
            }
            return bundle
        }
    }
    
    static var emojiBundle:Bundle {
        get {
            guard let bundleURL = Bundle(for: Theme.self).url(forResource: "ThemeEmoji", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) else {
                return Bundle(for: Theme.self)
            }
            return bundle
        }
    }
    
    static var insetBundle:Bundle {
        get {
            guard let bundleURL = Bundle(for: Theme.self).url(forResource: "ThemeInset", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) else {
                return Bundle(for: Theme.self)
            }
            return bundle
        }
    }
}

extension String {
    // TODO: delete public
    public var imaged: UIImage? {
        guard let image = UIImage(named: self, in: Theme.bundle, compatibleWith: nil) else {
            return UIImage(named: self)
        }
        return image
    }
}
