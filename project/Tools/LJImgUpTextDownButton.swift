//
//  LJImgUpTextDownButton.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

class LJImgUpTextDownButton: UIButton {
    
    private var btnFont = UIFont()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, fontSize: CGFloat) {
        self.init(frame: frame)
        btnFont = UIFont.lj_size(.bold, 14)
        commonInit(btnFont)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ font: UIFont) {
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .center
        titleLabel?.font = font
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX: CGFloat = 0;
        let titleY = contentRect.height * 0.75
        let titleW = contentRect.width
        let titleH = contentRect.height - titleY
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imgW = contentRect.width
        let imgH = contentRect.height * 0.7
        return CGRect(x: 0, y: 0, width: imgW, height: imgH)
    }
    
}
