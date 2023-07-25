//
//  ViewController.swift
//  ThemeKit_Example
//
//  Created by Zhang Yuf on 2023/7/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import ThemeKit
import SVGKit

class ViewController: UIViewController {
    
    private lazy var _button: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 200, y: 200, width: 100, height: 50)
        button.setTitle("Confirm", for: .normal)
        button.layer.borderWidth = 5.0
        button.setAlpha(floatPicker: [0.9, 0.6])
        button.layer.borderColor = .common_level1_color
        button.backgroundColor = .common_orange1_color
        button.setTitleColor(UIColor.common_level1_color, for: .normal)
        button.setImage(UIImage.arrow_left, for: .normal)
        button.addTarget(self, action: #selector(showSwitchVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var _textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 15, y: 300, width: UIScreen.main.bounds.width - 30, height: 55))
        textField.placeholder = "输入昵称"
        textField.setPlaceholderAttributes(attributesPicker: Appearance.Attributes.navigate_right_item_disabled)
        return textField
    }()
    
    private lazy var _imageView: UIImageView = {
        let imageView = UIImageView(image: Theme.image.icon_multi_card(size: CGSize(width: 50, height: 50)))
        imageView.frame.origin = CGPoint(x: 200, y: 400)
        return imageView
    }()
    
    private lazy var _svgView: UIImageView? = {
        let svgimage = SVGKImage(named: "light/icon_multi_update", in: Theme.bundle)
//        svgimage?.size = CGSize(width: 160, height: 160)
        
        let image = UIImage(named: "icon_multi_pic")
        UIGraphicsBeginImageContext(CGSize(width: 60, height: 60))
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        image?.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: 60, height: 60)))
        let drawImage = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        
        
        let imageView = UIImageView(image: Theme.image.icon_multi_notice(size: CGSize(width: 50, height: 50)))
        imageView.frame.origin = CGPoint(x: 200, y: 500)
        return imageView
    }()
    
    private lazy var _label: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 600, width: 100, height: 100))
        label.text = "TestDemo"
        label.font = .systemFont(ofSize: 20, weight: .heavy)
//        label.textColor = .common_orange1_color
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let item = UIBarButtonItem(image: Theme.image.icon_single_edit(), style: .plain, target: self, action: nil)
//        navigationItem.rightBarButtonItem = item
        view.backgroundColor = .common_bg1_color
//        item.setTitleTextAttributes(attributesPicker: Appearance.Attributes.navigate_right_item, for: .normal)
        
        view.addSubview(_button)
        view.addSubview(_textField)
        view.addSubview(_imageView)
//        if let _svgView = _svgView {
//            view.addSubview(_svgView)
//        }
        
        view.addSubview(_label)
        
        if #available(iOS 13.0, *) {
            let text = NSAttributedString(
                string: "text",
                attributes: [
                    //                .font: font,
                    .foregroundColor: UIColor.common_level1_color.lightValue,
                    .paragraphStyle: with(NSMutableParagraphStyle()) {
                        $0.lineSpacing = 2
                    },
                ]
            )
            let text_1 = NSAttributedString(
                string: "text",
                attributes: [
    //                .font: font,
                    .foregroundColor: UIColor.common_level1_color.darkValue,
                    .paragraphStyle: with(NSMutableParagraphStyle()) {
                        $0.lineSpacing = 2
                    },
                ]
            )
            let text_2 = NSMutableAttributedString(attributedString: text)
            text_2.append(text_1)
            _label.attributedText = Appearance.dynamicString([text, text_1], text)
            _button.setAttributedTitle(Appearance.dynamicString([text, text_1], text), for: .normal)
//            _label.attributedText = text_2
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func showSwitchVC() {
        self.navigationController?.pushViewController(ModeSwitchViewController(), animated: true)
    }
}

func with<T: AnyObject>(_ value: T, config: (T) throws -> ()) rethrows -> T {
    try config(value)
    return value
}
