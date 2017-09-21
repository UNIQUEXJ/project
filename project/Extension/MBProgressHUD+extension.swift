//
//  MBProgressHUD+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import MBProgressHUD

extension MBProgressHUD {
    static func lj_showText(superView view: UIView = lj_window, text str: String, time timeIndex: TimeInterval = 1.6) {
        let hud = MBProgressHUD()
        hud.bezelView.style = .blur  // 默认
        hud.minSize = CGSize(width: 100, height: 30)
        hud.mode = .text
        hud.center = view.center
        hud.label.text = str
        view.addSubview(hud)
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: timeIndex)
    }
    static func lj_showNet(superView view: UIView = lj_window,text str: String?) -> MBProgressHUD {
        let hud = MBProgressHUD()
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.clear
        hud.minSize = CGSize(width: 100, height: 30)
        hud.mode = .indeterminate
        hud.center = view.center
        hud.label.text = str
        hud.label.textColor = LJColor.textColor
        view.addSubview(hud)
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: 30)
        return hud
    }
    func lj_dismiss() {
        hide(animated: true)
    }
}
