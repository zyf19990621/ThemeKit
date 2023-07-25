//
//  UIKit+Theme.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/30.
//

import UIKit

extension UIView {
    static let swizzlingForView: Void = {
        DRuntime.methodSwizzling(cls: UIView.self, Selector(("setBackgroundColor:")), #selector(d_setBackgroundColor(with:)))
        DRuntime.methodSwizzling(cls: UIView.self, Selector(("setTintColor:")), #selector(d_setTintColor(with:)))
    }()
}

extension UILabel {
    static let swizzlingForLabel: Void = {
        DRuntime.methodSwizzling(cls: UILabel.self, Selector(("setTextColor:")), #selector(d_setTextColor(with:)))
        DRuntime.methodSwizzling(cls: UILabel.self, Selector(("setAttributedText:")), #selector(d_setAttributedText(with:)))
    }()
}

extension UIImageView {
    static let swizzlingForImageView: Void = {
        DRuntime.methodSwizzling(cls: UIImageView.self, Selector(("setImage:")), #selector(d_setImage(with:)))
    }()
}

extension UIButton {
    static let swizzlingForButton: Void = {
        DRuntime.methodSwizzling(cls: UIButton.self, Selector(("setTitleColor:forState:")), #selector(d_setTitleColor(with:for:)))
        DRuntime.methodSwizzling(cls: UIButton.self, Selector(("setImage:forState:")), #selector(d_setImage(with:for:)))
        DRuntime.methodSwizzling(cls: UIButton.self, Selector(("setBackgroundImage:forState:")), #selector(d_setBackgroundImage(with:for:)))
        DRuntime.methodSwizzling(cls: UIButton.self, Selector(("setAttributedTitle:forState:")), #selector(d_setAttributedTitle(with:for:)))
    }()
}

extension UITableView {
    static let swizzlingForTableView: Void = {
        DRuntime.methodSwizzling(cls: UITableView.self, Selector(("setSeparatorColor:")), #selector(d_setSeparatorColor(with:)))
        DRuntime.methodSwizzling(cls: UITableView.self, Selector(("setSectionIndexColor:")), #selector(d_setSectionIndexColor(with:)))
        DRuntime.methodSwizzling(cls: UITableView.self, Selector(("setSectionIndexBackgroundColor:")), #selector(d_setSectionIndexBackgroundColor(with:)))
        DRuntime.methodSwizzling(cls: UITableView.self, Selector(("setSectionIndexTrackingBackgroundColor:")), #selector(d_setSectionIndexTrackingBackgroundColor(with:)))
    }()
}

extension CALayer {
    static let swizzlingForLayer: Void = {
        DRuntime.methodSwizzling(cls: CALayer.self, Selector(("setBackgroundColor:")), #selector(d_setBackgroundColor(with:)))
        DRuntime.methodSwizzling(cls: CALayer.self, Selector(("setBorderColor:")), #selector(d_setBorderColor(with:)))
        DRuntime.methodSwizzling(cls: CALayer.self, Selector(("setFillColor:")), #selector(d_setFillColor(with:)))
        DRuntime.methodSwizzling(cls: CALayer.self, Selector(("setShadowColor:")), #selector(d_setShadowColor(with:)))
        DRuntime.methodSwizzling(cls: CALayer.self, Selector(("setStrokeColor:")), #selector(d_setStrokeColor(with:)))
    }()
}

extension UITextField {
    static let swizzlingForTextField: Void = {
        DRuntime.methodSwizzling(cls: UITextField.self, Selector(("setTextColor:")), #selector(d_setTextColor(with:)))
    }()
}

extension UITextView {
    static let swizzlingForTextView: Void = {
        DRuntime.methodSwizzling(cls: UITextView.self, Selector(("setTextColor:")), #selector(d_setTextColor(with:)))
    }()
}

extension UISearchBar {
    static let swizzlingForSearchBar: Void = {
        DRuntime.methodSwizzling(cls: UISearchBar.self, Selector(("setBarTintColor:")), #selector(d_setBarTintColor(with:)))
    }()
}

extension UINavigationBar {
    static let swizzlingForNavigationBar: Void = {
        DRuntime.methodSwizzling(cls: UINavigationBar.self, Selector(("setBarTintColor:")), #selector(d_setBarTintColor(with:)))
    }()
}

extension UITabBar {
    static let swizzlingForTabBar: Void = {
        DRuntime.methodSwizzling(cls: UITabBar.self, Selector(("setBarTintColor:")), #selector(d_setBarTintColor(with:)))
        DRuntime.methodSwizzling(cls: UITabBar.self, Selector(("setUnselectedItemTintColor:")), #selector(d_setUnselectedItemTintColor(with:)))
    }()
}

extension UIBarItem {
    static let swizzlingForBarItem: Void = {
        DRuntime.methodSwizzling(cls: UIBarItem.self, Selector(("setImage:")), #selector(d_setImage(with:)))
    }()
}

extension UITabBarItem {
    static let swizzlingForTabBarItem: Void = {
        DRuntime.methodSwizzling(cls: UITabBarItem.self, Selector(("setImage:")), #selector(d_setTabBarImage(with:)))
        DRuntime.methodSwizzling(cls: UITabBarItem.self, Selector(("setSelectedImage:")), #selector(d_setSelectedImage(with:)))
    }()
}

extension UISwitch {
    static let swizzlingForSwitch: Void = {
        DRuntime.methodSwizzling(cls: UISwitch.self, Selector(("setOnTintColor:")), #selector(d_setOnTintColor(with:)))
        DRuntime.methodSwizzling(cls: UISwitch.self, Selector(("setThumbTintColor:")), #selector(d_setThumbTintColor(with:)))
    }()
}

extension UISlider {
    static let swizzlingForSlider: Void = {
        DRuntime.methodSwizzling(cls: UISlider.self, Selector(("setThumbTintColor:")), #selector(d_setThumbTintColor(with:)))
        DRuntime.methodSwizzling(cls: UISlider.self, Selector(("setMinimumTrackTintColor:")), #selector(d_setMinimumTrackTintColor(with:)))
        DRuntime.methodSwizzling(cls: UISlider.self, Selector(("setMaximumTrackTintColor:")), #selector(d_setMaximumTrackTintColor(with:)))
    }()
}

extension UIProgressView {
    static let swizzlingForProgress: Void = {
        DRuntime.methodSwizzling(cls: UIProgressView.self, Selector(("setProgressTintColor:")), #selector(d_setProgressTintColor(with:)))
        DRuntime.methodSwizzling(cls: UIProgressView.self, Selector(("setTrackTintColor:")), #selector(d_setTrackTintColor(with:)))
    }()
}

extension UIPageControl {
    static let swizzlingForPageControl: Void = {
        DRuntime.methodSwizzling(cls: UIPageControl.self, Selector(("setPageIndicatorTintColor:")), #selector(d_setPageIndicatorTintColor(with:)))
        DRuntime.methodSwizzling(cls: UIPageControl.self, Selector(("setCurrentPageIndicatorTintColor:")), #selector(d_setCurrentPageIndicatorTintColor(with:)))
    }()
}

extension UIActivityIndicatorView {
    static let swizzlingForIndicator: Void = {
        DRuntime.methodSwizzling(cls: UIActivityIndicatorView.self, Selector(("setColor:")), #selector(d_setColor(with:)))
    }()
}

@available(iOS 13.0, *)
extension UIBarAppearance {
    static let swizzlingForAppearance: Void = {
        DRuntime.methodSwizzling(cls: UIBarAppearance.self, Selector(("setBackgroundColor:")), #selector(d_setBackgroundColor(with:)))
        DRuntime.methodSwizzling(cls: UIBarAppearance.self, Selector(("setBackgroundImage:")), #selector(d_setBackgroundImage(with:)))
        DRuntime.methodSwizzling(cls: UIBarAppearance.self, Selector(("setShadowColor:")), #selector(d_setShadowColor(with:)))
        DRuntime.methodSwizzling(cls: UIBarAppearance.self, Selector(("setShadowImage:")), #selector(d_setShadowImage(with:)))
    }()
}

public extension UIApplication
{
    @objc func setStatusBarStyle(picker: ThemeStatusBarStylePicker, animated: Bool) {
        picker.animated = animated
        setThemePicker(self, "setStatusBarStyle:animated:", picker)
    }
}

public extension UIView {
    @objc func setAlpha(floatPicker: ThemeCGFloatPicker?) {
        setThemePicker(self, "setAlpha:", floatPicker)
    }
}

public extension UITextField {
    @objc func setKeyboardAppearance(picker: ThemeKeyboardAppearancePicker?) {
        setThemePicker(self, "setKeyboardAppearance:", picker)
    }
    
    @objc func setPlaceholderAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "updatePlaceholderAttributes:", attributesPicker)
    }
}

public extension UITextView {
    @objc func setKeyboardAppearance(picker: ThemeKeyboardAppearancePicker?) {
        setThemePicker(self, "setKeyboardAppearance:", picker)
    }
}

public extension UIBarItem {
    @objc func setTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?, for state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setTitleTextAttributes:forState:", attributesPicker, state)
        setThemePicker(self, "setTitleTextAttributes:forState:", statePicker)
    }
}

public extension UINavigationBar {
    @objc func setTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "setTitleTextAttributes:", attributesPicker)
    }
    
    @objc func setLargeTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "setLargeTitleTextAttributes:", attributesPicker)
    }
    
    @available(iOS 13.0, *)
    @objc func setDynamicStandardAppearance(_ appearances: [UINavigationBarAppearance]) {
        setThemePicker(self, "setStandardAppearance:", ThemeNavigationBarAppearancePicker.pickerWithAppearances(appearances))
    }
    
    @available(iOS 13.0, *)
    func setDynamicCompactAppearance(_ appearances: [UINavigationBarAppearance]) {
        setThemePicker(self, "setCompactAppearance:", ThemeNavigationBarAppearancePicker.pickerWithAppearances(appearances))
    }
    
    @available(iOS 13.0, *)
    func setDynamicScrollEdgeAppearance(_ appearances: [UINavigationBarAppearance]) {
        setThemePicker(self, "setScrollEdgeAppearance:", ThemeNavigationBarAppearancePicker.pickerWithAppearances(appearances))
    }
    
    @available(iOS 15.0, *)
    func setDynamicCompactScrollEdgeAppearance(_ appearances: [UINavigationBarAppearance]) {
        setThemePicker(self, "setCompactScrollEdgeAppearance:", ThemeNavigationBarAppearancePicker.pickerWithAppearances(appearances))
    }
}

public extension UITabBar {
    @available(iOS 13.0, *)
    @objc func setDynamicStandardAppearance(_ appearances: [UITabBarAppearance]) {
        setThemePicker(self, "setStandardAppearance:", ThemeTabBarAppearancePicker.pickerWithAppearances(appearances))
    }
    
    @available(iOS 15.0, *)
    func setDynamicScrollEdgeAppearance(_ appearances: [UITabBarAppearance]) {
        setThemePicker(self, "setScrollEdgeAppearance:", ThemeTabBarAppearancePicker.pickerWithAppearances(appearances))
    }
}

@available(iOS 13.0, *)
public extension UINavigationBarAppearance {
    @objc func setTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "setTitleTextAttributes:", attributesPicker)
    }
    
    @objc func setLargeTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "setLargeTitleTextAttributes:", attributesPicker)
    }
}

@available(iOS 13.0, *)
public extension UIBarButtonItemStateAppearance {
    @objc func setTitleTextAttributes(attributesPicker: ThemeStringAttributesPicker?) {
        setThemePicker(self, "setTitleTextAttributes:", attributesPicker)
    }
}

fileprivate extension UIView {
    @objc func d_setBackgroundColor(with color: UIColor?) {
        /**
         * 理论上应该在color不带picker时清空当前object对应的themePicker，但目前工程中有太多对backgroundColor属性重复赋值的情况，remove可能导致预期设置的themePicker失效。
         * removeThemePicker(self, "setBackgroundColor:")
         */
        self.d_setBackgroundColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBackgroundColor:", themePicker) }
    }
    
    @objc func d_setTintColor(with color: UIColor) {
        guard let themePicker = color.themePicker else {
            self.d_setTintColor(with: color)
            return
        }
        setThemePicker(self, "setTintColor:", themePicker)
    }
}

fileprivate extension UILabel {
    @objc func d_setTextColor(with color: UIColor) {
        guard let themePicker = color.themePicker else {
            self.d_setTextColor(with: color)
            return
        }
        setThemePicker(self, "setTextColor:", themePicker)
    }
    
    @objc func d_setAttributedText(with attributedString: NSAttributedString?) {
        guard let themePicker = attributedString?.themePicker else {
            self.d_setAttributedText(with: attributedString)
            return
        }
        setThemePicker(self, "setAttributedText:", themePicker)
    }
}

fileprivate extension UIImageView {
    @objc func d_setImage(with image: UIImage?) {
        guard let themePicker = image?.themePicker else {
            self.d_setImage(with: image)
            return
        }
        setThemePicker(self, "setImage:", themePicker)
    }
}

fileprivate extension UIButton {
    @objc func d_setTitleColor(with color: UIColor?, for state: UIControl.State) {
        guard let themePicker = color?.themePicker else {
            self.d_setTitleColor(with: color, for: state)
            return
        }
        let statePicker = makeStatePicker(self, "setTitleColor:forState:", themePicker, state)
        setThemePicker(self, "setTitleColor:forState:", statePicker)
    }
    
    @objc func d_setImage(with image: UIImage?, for state: UIControl.State) {
        guard let themePicker = image?.themePicker else {
            self.d_setImage(with: image, for: state)
            return
        }
        let statePicker = makeStatePicker(self, "setImage:forState:", themePicker, state)
        setThemePicker(self, "setImage:forState:", statePicker)
    }
    
    @objc func d_setBackgroundImage(with image: UIImage?, for state: UIControl.State) {
        guard let themePicker = image?.themePicker else {
            self.d_setBackgroundImage(with: image, for: state)
            return
        }
        let statePicker = makeStatePicker(self, "setBackgroundImage:forState:", themePicker, state)
        setThemePicker(self, "setBackgroundImage:forState:", statePicker)
    }
    
    @objc func d_setAttributedTitle(with title: NSAttributedString?, for state: UIControl.State) {
        guard let themePicker = title?.themePicker else {
            self.d_setAttributedTitle(with: title, for: state)
            return
        }
        let statePicker = makeStatePicker(self, "setAttributedTitle:forState:", themePicker, state)
        setThemePicker(self, "setAttributedTitle:forState:", statePicker)
    }
}

fileprivate extension UITableView {
    /**
     * 由于setThemePicker中本身就会执行一遍performThemePicker，所以这里用guard let其实更合理，可以避免themeUpdate之后color.themePicker.value()和color本身色值不一致的问题。
     * 但在部分视图中(UITableView的separatorColor)因为未知原因，performThemePicker没能生效，所以在其中采用if let，即themePicker.value赋值后，再用原始color赋值一遍。
     *
     * For example:
     * if let themePicker = color?.themePicker { setThemePicker(self, "setSeparatorColor:", themePicker) }
     * self.d_setSeparatorColor(with: color)
     */
    @objc func d_setSeparatorColor(with color: UIColor?) {
        self.d_setSeparatorColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setSeparatorColor:", themePicker) }
    }
    
    @objc func d_setSectionIndexColor(with color: UIColor?) {
        self.d_setSectionIndexColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setSectionIndexColor:", themePicker) }
    }
    
    @objc func d_setSectionIndexBackgroundColor(with color: UIColor?) {
        self.d_setSectionIndexBackgroundColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setSectionIndexBackgroundColor:", themePicker) }
    }
    
    @objc func d_setSectionIndexTrackingBackgroundColor(with color: UIColor?) {
        self.d_setSectionIndexTrackingBackgroundColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setSectionIndexTrackingBackgroundColor:", themePicker) }
    }
}

fileprivate extension CALayer {
    @objc func d_setBackgroundColor(with color: CGColor?) {
        self.d_setBackgroundColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBackgroundColor:", themePicker) }
    }
    
    @objc func d_setBorderColor(with color: CGColor?) {
        self.d_setBorderColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBorderColor:", themePicker) }
    }
    
    @objc func d_setFillColor(with color: CGColor?) {
        self.d_setFillColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setFillColor:", themePicker) }
    }
    
    @objc func d_setShadowColor(with color: CGColor?) {
        self.d_setShadowColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setShadowColor:", themePicker) }
    }
    
    @objc func d_setStrokeColor(with color: CGColor?) {
        self.d_setStrokeColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setStrokeColor:", themePicker) }
    }
}

fileprivate extension UITextField {
    @objc func d_setTextColor(with color: UIColor?) {
        self.d_setTextColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setTextColor:", themePicker) }
    }
}

fileprivate extension UITextView {
    @objc func d_setTextColor(with color: UIColor?) {
        self.d_setTextColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setTextColor:", themePicker) }
    }
}

fileprivate extension UISearchBar {
    @objc func d_setBarTintColor(with color: UIColor?) {
        self.d_setBarTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBarTintColor:", themePicker) }
    }
}

fileprivate extension UINavigationBar {
    @objc func d_setBarTintColor(with color: UIColor?) {
        self.d_setBarTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBarTintColor:", themePicker) }
    }
}

fileprivate extension UITabBar {
    @objc func d_setBarTintColor(with color: UIColor?) {
        self.d_setBarTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBarTintColor:", themePicker) }
    }
    
    @objc func d_setUnselectedItemTintColor(with color: UIColor?) {
        self.d_setUnselectedItemTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setUnselectedItemTintColor:", themePicker) }
    }
}

fileprivate extension UIBarItem {
    @objc func d_setImage(with image: UIImage?) {
        guard let themePicker = image?.themePicker else {
            self.d_setImage(with: image)
            return
        }
        setThemePicker(self, "setImage:", themePicker)
    }
}

fileprivate extension UITabBarItem {
    @objc func d_setTabBarImage(with image: UIImage?) {
        guard let themePicker = image?.themePicker else {
            self.d_setTabBarImage(with: image)
            return
        }
        setThemePicker(self, "setImage:", themePicker)
    }
    
    @objc func d_setSelectedImage(with image: UIImage?) {
        guard let themePicker = image?.themePicker else {
            self.d_setSelectedImage(with: image)
            return
        }
        setThemePicker(self, "setSelectedImage:", themePicker)
    }
}

fileprivate extension UISwitch {
    @objc func d_setOnTintColor(with color: UIColor?) {
        self.d_setOnTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setOnTintColor:", themePicker) }
    }
    
    @objc func d_setThumbTintColor(with color: UIColor?) {
        self.d_setThumbTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setThumbTintColor:", themePicker) }
    }
}

fileprivate extension UISlider {
    @objc func d_setThumbTintColor(with color: UIColor?) {
        self.d_setThumbTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setThumbTintColor:", themePicker) }
    }
    
    @objc func d_setMinimumTrackTintColor(with color: UIColor?) {
        self.d_setMinimumTrackTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setMinimumTrackTintColor:", themePicker) }
    }
    
    @objc func d_setMaximumTrackTintColor(with color: UIColor?) {
        self.d_setMaximumTrackTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setMaximumTrackTintColor:", themePicker) }
    }
}

fileprivate extension UIProgressView {
    @objc func d_setProgressTintColor(with color: UIColor?) {
        self.d_setProgressTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setProgressTintColor:", themePicker) }
    }
    
    @objc func d_setTrackTintColor(with color: UIColor?) {
        self.d_setTrackTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setTrackTintColor:", themePicker) }
    }
}

fileprivate extension UIPageControl {
    @objc func d_setPageIndicatorTintColor(with color: UIColor?) {
        self.d_setPageIndicatorTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setPageIndicatorTintColor:", themePicker) }
    }
    
    @objc func d_setCurrentPageIndicatorTintColor(with color: UIColor?) {
        self.d_setCurrentPageIndicatorTintColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setCurrentPageIndicatorTintColor:", themePicker) }
    }
}

fileprivate extension UIActivityIndicatorView {
    @objc func d_setColor(with color: UIColor) {
        self.d_setColor(with: color)
        if let themePicker = color.themePicker { setThemePicker(self, "setColor:", themePicker) }
    }
}

@available(iOS 13.0, *)
fileprivate extension UIBarAppearance {
    @objc func d_setBackgroundColor(with color: UIColor?) {
        self.d_setBackgroundColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setBackgroundColor:", themePicker) }
    }
    
    @objc func d_setBackgroundImage(with image: UIImage?) {
        self.d_setBackgroundImage(with: image)
        if let themePicker = image?.themePicker { setThemePicker(self, "setBackgroundImage:", themePicker) }
    }
    
    @objc func d_setShadowColor(with color: UIColor?) {
        self.d_setShadowColor(with: color)
        if let themePicker = color?.themePicker { setThemePicker(self, "setShadowColor:", themePicker) }
    }
    
    @objc func d_setShadowImage(with image: UIImage?) {
        self.d_setShadowImage(with: image)
        if let themePicker = image?.themePicker { setThemePicker(self, "setShadowImage:", themePicker) }
    }
}

private func getThemePicker(
    _ object : NSObject,
    _ selector : String
) -> ThemePicker? {
    return ThemePicker.getThemePicker(object, selector)
}

private func setThemePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?
) {
    return ThemePicker.setThemePicker(object, selector, picker)
}

 private func removeThemePicker(
    _ object: NSObject,
    _ selector: String
) {
    return ThemePicker.removeThemePicker(object, selector)
}

private func makeStatePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?,
    _ state : UIControl.State
) -> ThemePicker? {
    return ThemePicker.makeStatePicker(object, selector, picker, state)
}
