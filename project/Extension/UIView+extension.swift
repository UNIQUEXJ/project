//
//  UIView+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UIView {
    
    /// 获取tabbar或者navbar的阴影线
    var lj_barLineView: UIImageView? {
        if self.isKind(of: UIImageView.self) && self.bounds.size.height <= 1.0 {
            return self as? UIImageView
        }
        for subView in self.subviews {
            let imageView = subView.lj_barLineView
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }
    /// 获取子控件里的button
    var lj_subButtons: [UIButton] {
        var btns: [UIButton] = []
        for item in subviews {
            if item.isKind(of: UIButton.self) {
                btns.append(item as! UIButton)
            }
        }
        return btns
    }
}
