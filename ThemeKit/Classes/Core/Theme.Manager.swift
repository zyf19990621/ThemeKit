//
//  Theme.Manager.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/29.
//

import Foundation

extension Notification.Name {
    static let themeUpdate = Notification.Name(rawValue: "ThemeUpdateNotification")
    static let barAppearanceUpdate = Notification.Name(rawValue: "BarAppearanceUpdateNotification")
}

enum ThemePath {
    
    case themeBundle
    case sandbox(Foundation.URL)
    
    var URL: Foundation.URL? {
        switch self {
        case .themeBundle        : return nil
        case .sandbox(let path) : return path
        }
    }
    
    func plistPath(name: String) -> String? {
        return filePath(name: name, ofType: "plist")
    }
    
    func jsonPath(name: String) -> String? {
        return filePath(name: name, ofType: "json")
    }
    
    private func filePath(name: String, ofType type: String) -> String? {
        switch self {
        case .themeBundle:
            return Theme.bundle.path(forResource: name, ofType: type)
        case .sandbox(let path):
            let name = name.hasSuffix(".\(type)") ? name : "\(name).\(type)"
            let url = path.appendingPathComponent(name)
            return url.path
        }
    }
}

@objc final class ThemeManager: NSObject {
    
    @objc static var animationDuration = 0.3
    
    @objc static var currentTheme: NSDictionary?
    @objc static var currentThemeIndex: Int = 0
    
    public static var currentThemePath: ThemePath?

}

extension ThemeManager {
    
    @objc class func setTheme(index: Int) {
        currentThemeIndex = index
        NotificationCenter.default.post(name: .themeUpdate, object: nil)
    }
    
    class func setTheme(plistName: String, path: ThemePath) {
        guard let plistPath = path.plistPath(name: plistName) else {
            print("ThemeKit WARNING: Can't find plist '\(plistName)' at: \(path)")
            return
        }
        guard let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            print("ThemeKit WARNING: Can't read plist '\(plistName)' at: \(plistPath)")
            return
        }
        self.setTheme(dict: plistDict, path: path)
    }
    
    class func setTheme(jsonName: String, path: ThemePath) {
        guard let jsonPath = path.jsonPath(name: jsonName) else {
            print("ThemeKit WARNING: Can't find json '\(jsonName)' at: \(path)")
            return
        }
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
            print("ThemeKit WARNING: Can't read json '\(jsonName)' at: \(jsonPath)")
            return
        }
        self.setTheme(dict: jsonDict, path: path)
    }
    
    class func setTheme(dict: NSDictionary, path: ThemePath) {
        currentTheme = dict
        currentThemePath = path
        NotificationCenter.default.post(name: .themeUpdate, object: nil)
    }
    
}

// MARK: ThemeManager + Index
extension ThemeManager {
    
    class func colorElement(for array: [String]) -> UIColor? {
        guard let rgba = element(for: array) else { return nil }
        guard let color = try? UIColor(rgba_throws: rgba as String) else {
            print("ThemeKit WARNING: Not convert rgba \(rgba) in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return color
    }
    
    class func imageElement(for array: [String]) -> UIImage? {
        guard let imageName = element(for: array) else { return nil }
        guard let image = imageName.imaged?.withRenderingMode(.alwaysOriginal) else {
            print("ThemeKit WARNING: Not found image name '\(imageName)' in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        image.themePicker = nil
        return image
    }
    
    class func element<T>(for array: [T]) -> T? {
        let index = ThemeManager.currentThemeIndex
        guard  array.indices ~= index else {
            print("ThemeKit WARNING: Not found element in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return array[index]
    }
    
}

// MARK: ThemeManager + Plist
@objc extension ThemeManager {
    
    class func value(for keyPath: String) -> Any? {
        return currentTheme?.value(forKeyPath: keyPath)
    }
    
    class func string(for keyPath: String) -> String? {
        guard let string = currentTheme?.value(forKeyPath: keyPath) as? String else {
            print("ThemeKit WARNING: Not found string key path: \(keyPath)")
            return nil
        }
        return string
    }
    
    class func number(for keyPath: String) -> NSNumber? {
        guard let number = currentTheme?.value(forKeyPath: keyPath) as? NSNumber else {
            print("ThemeKit WARNING: Not found number key path: \(keyPath)")
            return nil
        }
        return number
    }
    
    class func dictionary(for keyPath: String) -> NSDictionary? {
        guard let dict = currentTheme?.value(forKeyPath: keyPath) as? NSDictionary else {
            print("ThemeKit WARNING: Not found dictionary key path: \(keyPath)")
            return nil
        }
        return dict
    }
    
    class func color(for keyPath: String) -> UIColor? {
        guard let rgba = string(for: keyPath) else { return nil }
        guard let color = try? UIColor(rgba_throws: rgba) else {
            print("ThemeKit WARNING: Not convert rgba \(rgba) at key path: \(keyPath)")
            return nil
        }
        return color
    }
    
    class func image(for keyPath: String) -> UIImage? {
        guard let imageName = string(for: keyPath) else { return nil }
        if let filePath = currentThemePath?.URL?.appendingPathComponent(imageName).path {
            guard let image = UIImage(contentsOfFile: filePath) else {
                print("ThemeKit WARNING: Not found image at file path: \(filePath)")
                return nil
            }
            return image
        } else {
            guard let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) else {
                print("ThemeKit WARNING: Not found image name at main bundle: \(imageName)")
                return nil
            }
            return image
        }
    }
    
    class func font(for keyPath: String) -> UIFont? {
        guard let fontstr = string(for: keyPath) else { return nil }
        return font(from: fontstr)
    }
    
    class func font(from string: String) -> UIFont {
        let elements = string.components(separatedBy: ",")
        if elements.count == 2 {
            return UIFont(name: elements[0], size: CGFloat(Float(elements[1])!))!
        }
        
        if let fontSize = Float(string), fontSize > 0 {
            return UIFont.systemFont(ofSize: CGFloat(fontSize))
        }
        
        let value = "UICTFontTextStyle" + string.capitalized
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: value))
    }
    
}
