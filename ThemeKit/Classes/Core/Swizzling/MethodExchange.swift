//
//  MethodExchange.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/30.
//

import Foundation

struct DRuntime<T: NSObject> {
    private let _object: T
    
    public init(_ object: T) { _object = object }
}

extension DRuntime {
    /// 方法交换
    ///
    /// - Parameters:
    ///   - lSelector: 左边方法名
    ///   - rSelector: 右边方法名
    ///   - forInstance: 左右方法是否为实例方法，若设置为`false`，代表为类方法
    static func methodSwizzling(cls: AnyClass, _ lSelector: Selector, _ rSelector: Selector, forInstance: Bool = true) {
        guard NSStringFromSelector(lSelector) != NSStringFromSelector(rSelector) else { return }
        let getMethod: (Selector) -> Method? = {
            forInstance ? class_getInstanceMethod(cls, $0) : class_getClassMethod(cls, $0)
        }
        guard case let (a?, b?) = (getMethod(lSelector), getMethod(rSelector)) else { return }
        let didAddMethod = class_addMethod(cls, lSelector, method_getImplementation(b), method_getTypeEncoding(b))
        if didAddMethod {
            class_replaceMethod(cls, rSelector, method_getImplementation(a), method_getTypeEncoding(a))
        } else {
            method_exchangeImplementations(a, b);
        }
    }
}
