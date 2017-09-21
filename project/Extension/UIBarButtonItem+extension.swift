//
//  UIBarButtonItem+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UIBarButtonItem {
    
    //构造函数
    convenience init(imageName: String? = nil, title: String? = nil, titleColor: UIColor? = UIColor.white, target: AnyObject?, action: Selector) {
        self.init()
        let btn = UIButton()
        //给按钮添加点击事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        //设置图片
        if let img = imageName{
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
            btn.setImage(UIImage(named: img), for: .normal)
            btn.setImage(UIImage(named: img + "_highlighted"), for: .highlighted)
        }
        //设置文字大小
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(title, for: .normal)
        //设置颜色
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        //设置大小和内容的大小一致
        btn.sizeToFit()
        //设置自定义视图
        customView = btn
    }
    
    // 带指示图标的Bar
    convenience init(imageName: String? = nil, title: String? = nil, target: AnyObject?, action: Selector, count: Int? = nil) {
        self.init()
        let btn = UIButton()
        //给按钮添加点击事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        //设置图片
        if let img = imageName{
            //            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
            btn.setImage(UIImage(named: img)?.withRenderingMode(.alwaysOriginal), for: .normal)
            btn.setImage(UIImage(named: img), for: .highlighted)
        }
        //设置文字大小
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(title, for: .normal)
        //设置大小和内容的大小一致
        btn.sizeToFit()
        if let index = count {
            let label = UILabel()
            if index == 0 {
                label.isHidden = true
            }
            //            label.sizeToFit()
            
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.orange
            label.font = UIFont.lj_size(.system(0), 10)
            var labelContentWidth: CGFloat = 0
            let labelContentHeight = "\(index)".lj_stringHeight(UIFont.lj_size(.system(0), 10)) + 4
            label.layer.cornerRadius = labelContentHeight * 0.5
            label.layer.masksToBounds = true
            if index < 10 {
                labelContentWidth = labelContentHeight
                label.text = "\(index)"
            }else if index < 100 {
                labelContentWidth = "\(index)".lj_stringWidth(UIFont.lj_size(.system(0), 10)) + 4
                label.text = "\(index)"
            }else {
                labelContentWidth = "99+".lj_stringWidth(UIFont.lj_size(.system(0), 10)) + 4
                label.text = "99+"
            }
            btn.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(labelContentHeight * 0.5)
                make.top.equalToSuperview().inset(-labelContentHeight * 0.1)
                make.width.equalTo(labelContentWidth)
                make.height.equalTo(labelContentHeight)
            })
        }
        //设置自定义视图
        customView = btn
    }
    
}
