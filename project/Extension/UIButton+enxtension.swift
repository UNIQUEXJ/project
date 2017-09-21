//
//  UIButton+enxtension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UIButton {
    convenience init(_ title: String? = nil, _ fontSize: UIFont? = UIFont.systemFont(ofSize: 14), _ titleColor: UIColor? = LJColor.detailTextColor, _ backGroundColor: UIColor? = UIColor.white, _ image: UIImage? = nil) {
        self.init()
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = fontSize
        self.setTitleColor(titleColor, for: .normal)
        self.setImage(image, for: .normal)
    }
    
    /// 设置图片与文字交换前后位置
    func lj_changeImageWidthLabel() {
        titleEdgeInsets = UIEdgeInsetsMake(0, -(imageView?.frame.width)!, 0, (imageView?.frame.width)!)
        imageEdgeInsets = UIEdgeInsetsMake(0, (titleLabel?.frame.width)!, 0, -(titleLabel?.frame.width)!)
    }
}
