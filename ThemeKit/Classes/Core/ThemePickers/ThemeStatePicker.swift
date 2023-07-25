//
//  ThemeStatePicker.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 2022/6/29.
//

import Foundation

final class ThemeStatePicker: ThemePicker {
    
    typealias ValuesType = [UInt: ThemePicker]
    
    var values = ValuesType()
    
    convenience init?(picker: ThemePicker?, withState state: UIControl.State) {
        guard let picker = picker else { return nil }
        
        self.init(v: { 0 })
        values[state.rawValue] = picker
    }
    
    func setPicker(_ picker: ThemePicker?, forState state: UIControl.State) -> Self {
        values[state.rawValue] = picker
        return self
    }
    
}
