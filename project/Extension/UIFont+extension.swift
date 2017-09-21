//
//  UIFont+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

enum LJFontStyle {
    case system(CGFloat?)
    case bold
    case italic
}

extension UIFont {
    static func lj_size(_ style: LJFontStyle, _ size: CGFloat = 14) -> UIFont {
        switch style {
        case .system(let weight):
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight ?? 0))
        case .bold:
            return UIFont.boldSystemFont(ofSize: size)
        case .italic:
            return UIFont.italicSystemFont(ofSize: size)
        }
    }
}
