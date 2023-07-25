//
//  Appearance+UIImage.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/7/13.
//

import Foundation
import UIKit
import SVGKit

extension Theme {
    @objc(ThemeImage)
    public class image: NSObject {}
}

extension Theme.image {
    struct Resource {
        /// Bundle this image is in
        let bundle: Bundle
        /// Name of the image
        let name: String
        
        init(bundle: Bundle, name: String) {
            self.bundle = bundle
            self.name = name
        }
    }
}

fileprivate var imagePickerKey = "ImagePicker"

extension UIImage
{
    public var themePicker: ThemeImagePicker? {
        get {
            objc_getAssociatedObject(self, &imagePickerKey) as? ThemeImagePicker
        }
        set {
            objc_setAssociatedObject(self, &imagePickerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public extension Appearance
{
    class func dynamicImage(images: [UIImage?]) -> UIImage? {
        let imageArray = images.compactMap { $0 }
        return makeDynamicImage(images.description, ThemeImagePicker.pickerWithImages(imageArray), imageArray.first)
    }
}

@objc public extension UIImage
{
    static var oneImage: UIImage? {
        makeDynamicImage("oneImage", ["icon_department_light", "icon_department_dark"], "icon_department_light".imaged)
    }
    
    static var arrow_left: UIImage? {
        makeDynamicImage("arrow_left", ["arrow_left_light", "arrow_left_dark"], "arrow_left_light".imaged)
    }
    
    static var arrow_right: UIImage? {
        makeDynamicImage("arrow_right", ["arrow_right_light", "arrow_right_dark"], "arrow_right_light".imaged)
    }
    
    static var search_icon: UIImage? {
        makeDynamicImage("search_icon", ["icon_search_light", "icon_search_dark"], "icon_search_light".imaged)
    }
    
    static var bg_search: UIImage? {
        makeDynamicImage("bg_search", ["bg_search_light", "bg_search_dark"], "bg_search_light".imaged)
    }
    
    static var efficiency_add: UIImage? {
        makeDynamicImage("efficiency_add", ["efficiency_add_light", "efficiency_add_dark"], "efficiency_add_light".imaged)
    }
    
    static var efficiency_delete: UIImage? {
        makeDynamicImage("efficiency_delete", ["efficiency_delete_light", "efficiency_delete_dark"], "efficiency_delete_light".imaged)
    }
    
    static var efficiency_delete_gray: UIImage? {
        makeDynamicImage("efficiency_delete_gray", ["efficiency_delete_gray", "efficiency_delete_gray_dark"], "efficiency_delete_gray".imaged)
    }
    
    static var efficiency_yidong: UIImage? {
        makeDynamicImage("efficiency_yidong", ["efficiency_yidong", "efficiency_yidong_dark"], "efficiency_yidong".imaged)
    }
    
    static var efficiency_yidong_gary: UIImage? {
        makeDynamicImage("efficiency_yidong_gary", ["efficiency_yidong_gary", "efficiency_yidong_dark"], "efficiency_yidong_gary".imaged)
    }
    
    static var cagegory_setup: UIImage? {
        makeDynamicImage("cagegory_setup", ["cagegory_setup_light", "cagegory_setup_dark"], "cagegory_setup_light".imaged)
    }
    
    static var icon_more: UIImage? {
        makeDynamicImage("icon_more", ["icon_more_light", "icon_more_dark"], "icon_more_light".imaged)
    }
    
    static var icon_smile: UIImage? {
        makeDynamicImage("icon_smile", ["icon_smile_light", "icon_smile_dark"], "icon_smile_light".imaged)
    }
    
    static var icon_voice: UIImage? {
        makeDynamicImage("icon_voice", ["icon_voice_light", "icon_voice_dark"], "icon_voice_light".imaged)
    }
    
    static var bg_wallet: UIImage? {
        makeDynamicImage("bg_wallet", ["bg_card_light", "bg_card_dark"], "bg_card_light".imaged)
    }
    
    static var btn_paycode: UIImage? {
        makeDynamicImage("btn_paycode", ["btn_paycode_light", "btn_paycode_dark"], "btn_paycode_light".imaged)
    }
    
    static var bg_redenvelope: UIImage? {
        makeDynamicImage("bg_redenvelope", ["bg_redenvelope_light", "bg_redenvelope_dark"], "bg_redenvelope_light".imaged)
    }
    
    static var btn_redenvelope_disabled: UIImage? {
        makeDynamicImage("btn_redenvelope_disabled", ["btn_redenvelope_disabled_light", "btn_redenvelope_disabled_dark"], "btn_redenvelope_disabled_light".imaged)
    }
    
    static var common_bg1_image: UIImage? {
        makeDynamicImage("common_bg1_image", ThemeImagePicker(images: UIImage(color: UIColor(rgba: "#f7f7f7ff")) ?? UIImage(), UIImage(color: UIColor(rgba: "#0a0a0aff")) ?? UIImage()), UIImage(color: UIColor(rgba: "#f7f7f7ff")))
    }
}

@objc public extension UIImage
{
    static var calendar_dayview_3days_image: UIImage? {
        makeDynamicImage("calendar_dayview_3days_image", ["calendar_dayview_3days_light", "calendar_dayview_3days_dark"], "calendar_dayview_3days_light".imaged)
    }
    
    static var calendar_dayview_daily_image: UIImage? {
        makeDynamicImage("calendar_dayview_daily_image", ["calendar_dayview_daily_light", "calendar_dayview_daily_dark"], "calendar_dayview_daily_light".imaged)
    }
    
    static var calendar_settings_bubble_image: UIImage? {
        makeDynamicImage("calendar_settings_bubble_image", ["calendar_settings_bubble_light", "calendar_settings_bubble_dark"], "calendar_settings_bubble_light".imaged)
    }
    
    static var calendar_icon_timeMargin_image: UIImage? {
        makeDynamicImage("calendar_icon_timeMargin_image", ["calendar_icon_timeMargin_light", "calendar_icon_timeMargin_dark"], "calendar_icon_timeMargin_light".imaged)
    }
    
    static var calendar_more_setting_image: UIImage? {
        makeDynamicImage("calendar_more_setting_image", ["calendar_more_setting_light", "calendar_more_setting_dark"], "calendar_more_setting_light".imaged)
    }
    
    static var calendar_open_meeting_image: UIImage? {
        makeDynamicImage("calendar_open_meeting_image", ["calendar_open_meeting_light", "calendar_open_meeting_dark"], "calendar_open_meeting_light".imaged)
    }
}

@objc public extension UIImage
{
    static var todo_list_more_image: UIImage? {
        makeDynamicImage("todo_list_more_image", ["todo_list_more_light", "todo_list_more_dark"], "todo_list_more_light".imaged)
    }

    static var todo_list_arrow_image: UIImage? {
        makeDynamicImage("todo_list_arrow_image", ["todo_list_arrow_light", "todo_list_arrow_dark"], "todo_list_arrow_light".imaged)
    }

    static var todo_detail_share_image: UIImage? {
        makeDynamicImage("todo_detail_share_image", ["todo_detail_share_light", "todo_detail_share_dark"], "todo_detail_share_light".imaged)
    }
}

@objc public extension UIImage {
    static var cooper_more_image: UIImage? {
        makeDynamicImage("cooper_more_image", ["cooper_more_icon_light", "cooper_more_icon_dark"], "cooper_more_icon_light".imaged)
    }

    static var cooper_search_image: UIImage? {
        makeDynamicImage("cooper_search_image", ["cooper_search_icon_light", "cooper_search_icon_dark"], "cooper_search_icon_light".imaged)
    }
}

func getDynamicImage(
    _ resource: Theme.image.Resource,
    _ color: UIColor?,
    _ size: CGSize
) -> UIImage? {
    let svgImage = SVGKImage(named: resource.name, in: resource.bundle)
    if !size.equalTo(CGSize.zero) { svgImage?.size = size }
    
    guard #available(iOS 13.0, *) else { return svgImage?.uiImage }
    guard let color = color else {
        let defaultColor = UIColor.common_icon2_color
        let imagePicker = ThemeImagePicker.pickerWithSVG(svgImage, colors: [defaultColor.lightValue, defaultColor.darkValue])
        let image: UIImage? = imagePicker.value() as? UIImage ?? svgImage?.uiImage
        image?.themePicker = imagePicker
        return image
    }
    guard let _ = color.themePicker else { return svgImage?.uiImage.withTintColor(color) }
    
    let imagePicker = ThemeImagePicker.pickerWithSVG(svgImage, colors: [color.lightValue, color.darkValue])
    let image: UIImage? = imagePicker.value() as? UIImage ?? svgImage?.uiImage
    image?.themePicker = imagePicker
    return image
}

func getDynamicImage(
    _ resource: Theme.image.Resource,
    _ size: CGSize
) -> UIImage? {
    let lightImage = SVGKImage(named: "light/\(resource.name)", in: resource.bundle)
    let darkImage = SVGKImage(named: "dark/\(resource.name)", in: resource.bundle)
    if !size.equalTo(CGSize.zero) {
        lightImage?.size = size
        darkImage?.size = size
    }
    return Appearance.dynamicImage(images: [lightImage?.uiImage, darkImage?.uiImage])
}

private func makeDynamicImage(
    _ name: String,
    _ themePicker: ThemeImagePicker,
    _ defaultValue: UIImage?
) -> UIImage? {
    let image: UIImage? = themePicker.value() as? UIImage ?? defaultValue
    image?.themePicker = themePicker
    return image
}
