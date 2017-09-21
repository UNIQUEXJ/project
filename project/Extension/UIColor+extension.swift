//
//  UIColor+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UIColor {
    
    /// 用十六进制颜色创建UIColor
    ///
    /// - Parameter hexColor: 十六进制颜色 (0F0F0F)
    convenience init(hexColor: String) {
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0, alpha: UInt32 = 255
        // 分别转换进行转换
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        
        if hexColor.lengthOfBytes(using: .utf8) == 8 {
            Scanner(string: hexColor[6..<8]).scanHexInt32(&alpha)
        }
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
    }
    /// RGB颜色
    static func lj_colorRGB(_ r: Float, _ g: Float, _ b: Float, _ a: Float) -> UIColor {
        
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
        } else {
            return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
        }
    }
    /// 设置纯黑白颜色
    static func lj_colorChun(_ rgb: Float, _ a: Float) -> UIColor {
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: CGFloat(rgb) / 255, green: CGFloat(rgb) / 255, blue: CGFloat(rgb) / 255, alpha: CGFloat(a))
        } else {
            return UIColor(red: CGFloat(rgb) / 255, green: CGFloat(rgb) / 255, blue: CGFloat(rgb) / 255, alpha: CGFloat(a))
        }
    }
    static func lj_randomColor() -> UIColor {
        let weight = CGFloat(arc4random_uniform(1000)) / 1000
        return UIColor(hue: weight, saturation: 1, brightness: 1, alpha: 1)
    }
}
