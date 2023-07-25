//
//  ThemeImagePicker.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/13.
//

import Foundation
import SVGKit

@objc public final class ThemeImagePicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.image(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIImage?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(names: String...) {
        self.init(v: { ThemeManager.imageElement(for: names) })
    }
    
    public convenience init(images: UIImage...) {
        self.init(v: {
            /// 防止方法交换后，递归调用。
            guard let image = ThemeManager.element(for: images), let cgImage = image.cgImage else { return nil }
            return UIImage(cgImage: cgImage)
        })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.imageElement(for: elements) })
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

@objc public extension ThemeImagePicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeImagePicker {
        return ThemeImagePicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIImage?) -> ThemeImagePicker {
        return ThemeImagePicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithNames(_ names: [String]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { ThemeManager.imageElement(for: names) })
    }
    
    class func pickerWithImages(_ images: [UIImage]) -> ThemeImagePicker {
        return ThemeImagePicker(v: {
            /// 防止方法交换后，递归调用。
            guard let image = ThemeManager.element(for: images) else { return nil }
            let renderer = UIGraphicsImageRenderer.init(size: image.size)
            return renderer.image { _ in image.draw(at: .zero) }
        })
    }
    
    @available(iOS 13.0, *)
    class func pickerWithSVG(_ svgImage: SVGKImage?, colors: [UIColor]) -> ThemeImagePicker {
        return ThemeImagePicker(v: {
            guard let color = ThemeManager.element(for: colors) else { return svgImage?.uiImage }
            return svgImage?.uiImage.withTintColor(color).withRenderingMode(.alwaysOriginal)
        })
    }
    
}

extension ThemeImagePicker: ExpressibleByArrayLiteral {}
extension ThemeImagePicker: ExpressibleByStringLiteral {}

