//
//  ModeSwitchViewController.swift
//  ThemeKit_Example
//
//  Created by Zhang Yuf on 2023/7/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import ThemeKit

public class ModeSwitchViewController: UIViewController {
    
    fileprivate typealias ModeCell = ModeSwitchCollectionViewCell
    fileprivate let ModeCellIdentifier = "ModeSwitchCollectionViewCell"
    
    private lazy var _collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 64.0, height: 178.0)
        layout.sectionInset = UIEdgeInsets(top: 26.0, left: 46.0, bottom: 20.0, right: 46.0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .common_bg2_color
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ModeCell.self, forCellWithReuseIdentifier: ModeCellIdentifier)
        return collection
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "深色模式"
        view.backgroundColor = .common_bg1_color
        view.addSubview(_collectionView)
        NSLayoutConstraint.activate([
            _collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            _collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            _collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            _collectionView.heightAnchor.constraint(equalToConstant: 424.0)
        ])
    }
}

extension ModeSwitchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width - 46.0 * 2 - 64.0 * 3) / 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCellIdentifier, for: indexPath) as? ModeCell ?? ModeCell()
        cell.layoutUI(row: indexPath.row)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.visibleCells.forEach { $0.isSelected = false }
        switch indexPath.row {
        case 0:
            Theme.userDefined = false
            if #available(iOS 13.0, *) {
                Theme.switchToDark(UITraitCollection.current.userInterfaceStyle == .dark)
            }
        case 1:
            Theme.userDefined = true
            Theme.switchToDark(false)
        case 2:
            Theme.userDefined = true
            Theme.switchToDark(true)
        default:
            break
        }
    }
}

private extension ModeSwitchViewController {
    class ModeSwitchCollectionViewCell: UICollectionViewCell {
        private lazy var _imageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        private lazy var _titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14.0)
            label.textColor = .common_level1_color
            return label
        }()
        
        private lazy var _selectedIcon: UIImageView = {
            let icon = UIImageView(image: UIImage(named: "ic_check"))
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.contentMode = .scaleAspectFit
            return icon
        }()
        
        override var isSelected: Bool {
            didSet {
                _selectedIcon.image = UIImage(named: (isSelected ? "ic_check_selected" : "ic_check"))
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            _initAppearance()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func _initAppearance() {
            contentView.addSubview(_imageView)
            contentView.addSubview(_titleLabel)
            contentView.addSubview(_selectedIcon)
            
            NSLayoutConstraint.activate([
                _imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                _imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                _imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                _imageView.heightAnchor.constraint(equalToConstant: 120.0),
                _titleLabel.topAnchor.constraint(equalTo: _imageView.bottomAnchor, constant: 8.0),
                _titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                _selectedIcon.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10.0),
                _selectedIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                _selectedIcon.widthAnchor.constraint(equalToConstant: 20.0),
                _selectedIcon.heightAnchor.constraint(equalToConstant: 20.0)
            ])
        }
        
        func layoutUI(row: Int) {
            var iconSelected = false
            switch row {
            case 0:
                _titleLabel.text = "跟随系统"
                _imageView.image = UIImage(named: "icon_mode_default")
                iconSelected = !Theme.userDefined
            case 1:
                _titleLabel.text = "浅色"
                _imageView.image = UIImage(named: "icon_mode_light")
                iconSelected = Theme.userDefined && Theme.current == .light
            case 2:
                _titleLabel.text = "深色"
                _imageView.image = UIImage(named: "icon_mode_dark")
                iconSelected = Theme.userDefined && Theme.current == .dark
            default:
                return
            }
            _selectedIcon.image = UIImage(named: (iconSelected ? "ic_check_selected" : "ic_check"))
        }
    }
}
